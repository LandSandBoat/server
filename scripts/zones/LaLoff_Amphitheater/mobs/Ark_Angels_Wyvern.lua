-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Wyvern
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-7, mobid do
        local m = GetMobByID(member)
        if m and m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
