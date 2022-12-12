-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Wyvern
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-7, mobid do
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
