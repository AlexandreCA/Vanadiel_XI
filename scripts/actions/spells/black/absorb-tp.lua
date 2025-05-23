-----------------------------------
-- Spell: Absorb-TP
-- Steals an enemy's TP.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.absorb.doAbsorbTPSpell(caster, target, spell)
end

return spellObject
