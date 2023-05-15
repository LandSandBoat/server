-----------------------------------
-- Spell: Warp
-- Transports the user to their Home Point
-----------------------------------
require("scripts/globals/spells/enhancing_teleport")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:getZoneID() == 131 then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useTeleportSpell(caster, target, spell)
end

return spellObject
