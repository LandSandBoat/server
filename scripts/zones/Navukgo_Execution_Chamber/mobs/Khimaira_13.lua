-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Khimaira 13
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if v:getName() == "Karababa" then
            v:addEnmity(mob, 0, 1)
        end
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("updateCSID: %u", csid)
end

entity.onEventFinish = function(player, csid, option, target)
    -- printf("finishCSID: %u", csid)
end

return entity
