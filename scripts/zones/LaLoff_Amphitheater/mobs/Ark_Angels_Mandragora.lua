-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Mandragora
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

-- TODO: Determine spell list and behavior.  Potentially includes Breakga and Bindga, unless they're TP moves.
-- TODO: Implement shared spawn and victory conditions with Ark Angel's Tiger.

entity.onMobEngaged = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-3, mobid + 4 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
