-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Khimaira 13
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for _, allyObj in ipairs(bcnmAllies) do
        if allyObj:getName() == 'Karababa' then
            allyObj:addEnmity(mob, 0, 1)
            allyObj:updateEnmity(mob)
        end
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
