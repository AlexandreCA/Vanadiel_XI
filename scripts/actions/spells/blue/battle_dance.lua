-----------------------------------
-- Spell: Battle Dance
-- Delivers an area attack. Additional effect: DEX Down. Duration of effect varies with TP
-- Spell cost: 12 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2
-- Level: 12
-- Casting Time: 1 second
-- Recast Time: 10 seconds
-- Skillchain Element(s): Impaction
-- Combos: Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.BEASTMEN
    params.tpmod      = xi.spells.blue.tpMod.DURATION
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr     = xi.skillchainType.IMPACTION
    params.numhits    = 1
    params.multiplier = 2.0
    params.tp150      = 2.0
    params.tp300      = 2.0
    params.azuretp    = 2.0
    params.duppercap  = 17
    params.str_wsc    = 0.3
    params.dex_wsc    = 0.0
    params.vit_wsc    = 0.0
    params.agi_wsc    = 0.0
    params.int_wsc    = 0.0
    params.mnd_wsc    = 0.0
    params.chr_wsc    = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.DEX_DOWN, 9, 6, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
