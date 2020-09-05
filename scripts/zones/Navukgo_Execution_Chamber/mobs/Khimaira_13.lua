-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Khimaira 13
-----------------------------------

function onMobEngaged(mob, target)
    local bcnmAllies = mob:getBattlefield():getAllies()
    for i, v in pairs(bcnmAllies) do
        if v:getName() == "Karababa" then
            v:addEnmity(mob, 0, 1)
        end
    end
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

function onEventUpdate(player, csid, option)
    -- printf("updateCSID: %u", csid)
end

function onEventFinish(player, csid, option, target)
    -- printf("finishCSID: %u", csid)
end
