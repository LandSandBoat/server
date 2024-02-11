-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Tiger
-----------------------------------
local entity = {}

-- TODO: Implement shared spawning and victory system with Ark Angel's Mandragora.

entity.onMobEngage = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-2, mobid + 5 do
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
