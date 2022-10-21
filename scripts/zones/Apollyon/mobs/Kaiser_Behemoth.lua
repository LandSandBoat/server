-----------------------------------
-- Area: Apollyon NW, Floor 5
--  Mob: Kaiser Behemoth
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end
end

return entity
