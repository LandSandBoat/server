-----------------------------------
-- Area: Al'Taieu
--   NM: Ru'aern
-- Note: Spawned by Rubious Crystals for PM 8-1
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
local entity = {}

local function clearTowerVars(player, towerNum)
    player:setCharVar('Ru_aern_'..towerNum..'-1KILL', 0)
    player:setCharVar('Ru_aern_'..towerNum..'-2KILL', 0)
    player:setCharVar('Ru_aern_'..towerNum..'-3KILL', 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY and
        player:getCharVar('PromathiaStatus') < 3
    then
        local aernKills =
        {
            [ID.mob.RUAERN_BASE + 0] = 'Ru_aern_1-1KILL',
            [ID.mob.RUAERN_BASE + 1] = 'Ru_aern_1-2KILL',
            [ID.mob.RUAERN_BASE + 2] = 'Ru_aern_1-3KILL',
            [ID.mob.RUAERN_BASE + 3] = 'Ru_aern_2-1KILL',
            [ID.mob.RUAERN_BASE + 4] = 'Ru_aern_2-2KILL',
            [ID.mob.RUAERN_BASE + 5] = 'Ru_aern_2-3KILL',
            [ID.mob.RUAERN_BASE + 6] = 'Ru_aern_3-1KILL',
            [ID.mob.RUAERN_BASE + 7] = 'Ru_aern_3-2KILL',
            [ID.mob.RUAERN_BASE + 8] = 'Ru_aern_3-3KILL',
        }

        local varToSet = aernKills[mob:getID()]

        if varToSet ~= nil then
            player:setCharVar(varToSet, 1)
        end

        if
            player:getCharVar('Ru_aern_1-1KILL') == 1 and
            player:getCharVar('Ru_aern_1-2KILL') == 1 and
            player:getCharVar('Ru_aern_1-3KILL') == 1
        then
            player:setCharVar('[SEA][AlTieu]SouthTower', 1)
            clearTowerVars(player, 1)
        end

        if
            player:getCharVar('Ru_aern_2-1KILL') == 1 and
            player:getCharVar('Ru_aern_2-2KILL') == 1 and
            player:getCharVar('Ru_aern_2-3KILL') == 1
        then
            player:setCharVar('[SEA][AlTieu]WestTower', 1)
            clearTowerVars(player, 2)
        end

        if
            player:getCharVar('Ru_aern_3-1KILL') == 1 and
            player:getCharVar('Ru_aern_3-2KILL') == 1 and
            player:getCharVar('Ru_aern_3-3KILL') == 1
        then
            player:setCharVar('[SEA][AlTieu]EastTower', 1)
            clearTowerVars(player, 3)
        end
    end
end

return entity
