-----------------------------------
-- Spell: Meteor
-- Deals non-elemental damage to an enemy.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- TODO: Correct message is "Incorrect job, job level too low, or required ability not activated."  Unable to locate this in our basic or system message functions.
    -- The client blocks the spell via menus, but it can still be cast via text commands, so we have to block it here, albiet with the wrong message.
    if caster:isMob() then
        return 0
    elseif caster:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) then
        return 0
    else
        return xi.msg.basic.STATUS_PREVENTS
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    --calculate raw damage
    --Byrthnoth @ Random Facts Thread: Magic @ BG:
    --Spell Base Damage = MAB/MDB*floor(Int + Elemental Magic Skill/6)*3.5
    --NOT AFFECTED BY DARK BONUSES (bonus ETC)
    --I'll just point this out again. It can't resist, there's no dINT, and the damage is non-elemental. The only terms that affect it for monsters (that we know of) are MDB and MDT. If a --normal monster would take 50k damage from your group, Botulus would take 40k damage. Every. Time.
    local damage = 0
    if caster:isPC() then
        damage = ((100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF))) * (caster:getStat(xi.mod.INT) + caster:getSkillLevel(xi.skill.ELEMENTAL_MAGIC) / 6) * 3.5
    elseif -- Behemoth family
        caster:getFamily() == 51 or
        caster:getFamily() == 479
    then
        -- Not entirely accurate until mobspell skills are reworked. #7222
        -- TODO: + dINT *2 until dINT +13. When dINT is negative, dINT / 2 until unknown floor.
        -- TODO: Account for all mitigation sources.
        -- TODO: Account for rage.
        damage = caster:getMainLvl() * 15.5
    else
        damage = ((100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF))) * (caster:getStat(xi.mod.INT) + (caster:getMaxSkillLevel(caster:getMainLvl(), xi.job.BLM, xi.skill.ELEMENTAL_MAGIC)) / 6) * 9.4
    end

    damage = math.floor(damage * xi.spells.damage.calculateNukeAbsorbOrNullify(target, xi.element.NONE))
    damage = math.floor(damage * xi.spells.damage.calculateMTDR(spell))
    damage = math.floor(damage * xi.spells.damage.calculateTMDA(target, xi.element.NONE))

    -- Handle Phalanx, One for All, Stoneskin.
    damage = utils.clamp(damage - target:getMod(xi.mod.PHALANX), 0, 99999)
    damage = utils.clamp(utils.oneforall(target, damage), 0, 99999)
    damage = utils.clamp(utils.stoneskin(target, damage), -99999, 99999)

    -- Handle final adjustments. Most are located in core. TODO: Decide if we want core handling this.
    -- Check if the mob has a damage cap
    damage = target:checkDamageCap(damage)

    -- Handle Bind break and TP?
    target:takeSpellDamage(caster, spell, damage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    -- Handle Afflatus Misery.
    target:handleAfflatusMiseryDamage(damage)

    -- Handle Enmity.
    target:updateEnmityFromDamage(caster, damage)

    return damage
end

return spellObject
