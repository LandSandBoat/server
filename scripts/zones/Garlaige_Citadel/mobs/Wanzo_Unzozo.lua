-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wanzo-Unzozo
-- Type: Quest mob (Escort for Hire - Windurst)
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------
ID = require('scripts/zones/Garlaige_Citadel/IDs')
-----------------------------------
local entity = {}

local route =
{
    { x = -381.0000, y = -12.0000, z = 398.0000 },
    { x = -380.8830, y = -12.0000, z = 391.8802 },
    { x = -378.7068, y = -6.12510, z = 368.4137 },
    { x = -379.2549, y = -6.00000, z = 346.8558 },
    { x = -357.3971, y = -6.00000, z = 338.0250 },
    { x = -341.3876, y = -3.25000, z = 339.8453 },
    { x = -340.9149, y = 0.000000, z = 297.0475 },
    { x = -336.8979, y = 0.000000, z = 288.6178 },
    { x = -342.1649, y = 0.000000, z = 270.2281 },
    { x = -354.1182, y = 0.000000, z = 268.7367 },
    { x = -354.2867, y = 0.000000, z = 249.9196 },
    { x = -340.2825, y = 0.000000, z = 249.7256 },
    { x = -337.6853, y = 0.000000, z = 221.3183 },
    { x = -314.6676, y = 0.000000, z = 218.6108 },
    { x = -300.1329, y = 0.000000, z = 226.1669 },
    { x = -275.1773, y = 0.000000, z = 217.3463 },
    { x = -271.0707, y = 0.000000, z = 219.7949 }, -- Middle of holes
    { x = -237.1567, y = 0.000000, z = 218.0966 },
    { x = -180.1768, y = 0.000000, z = 221.7442 },
    { x = -178.3567, y = 0.000000, z = 259.3759 },
    { x = -143.2720, y = 0.000000, z = 262.7013 },
    { x = -138.2194, y = 0.000000, z = 230.2753 },
    { x = -125.7615, y = 0.000000, z = 229.9893 },
    { x = -126.1223, y = 0.000000, z = 217.9252 },
    { x = -133.0517, y = 0.000000, z = 204.5436 }, -- Dead End
    { x = -126.1223, y = 0.000000, z = 217.9252 },
    { x = -125.7615, y = 0.000000, z = 229.9893 },
    { x = -138.2194, y = 0.000000, z = 230.2753 },
    { x = -138.9951, y = 0.000000, z = 254.4034 },
    { x = -106.9740, y = 0.000000, z = 262.5682 },
    { x = -100.8588, y = 0.000000, z = 256.1013 },
    { x = -97.54940, y = 0.000000, z = 222.0876 },
    { x = -65.87720, y = 0.000000, z = 217.7562 },
    { x = -57.52250, y = 0.000000, z = 192.7869 },
    { x = -60.73950, y = 5.927000, z = 153.6628 }, -- Basement
    { x = -54.09130, y = 7.176200, z = 143.8619 },
    { x = -42.03350, y = 6.000000, z = 144.9311 },
    { x = -30.21860, y = 7.443100, z = 137.7087 },
    { x = -17.81050, y = 6.567400, z = 147.5737 },
    { x = -16.16890, y = 8.139700, z = 138.4585 },
    { x = -20.54190, y = 6.000000, z = 118.7473 },
    { x = -19.41390, y = 2.750000, z = 101.3711 },
    { x = -101.4705, y = 0.000000, z = 100.9095 },
    { x = -167.2571, y = 0.000000, z = 98.46240 },
    { x = -177.5856, y = 0.000000, z = 94.07690 },
    { x = -210.6050, y = 0.000000, z = 102.8821 },
    { x = -220.0769, y = 0.000000, z = 110.8499 },
    { x = -216.9912, y = 0.000000, z = 128.0300 },
    { x = -219.6814, y = 0.000000, z = 139.8317 }, -- Destination
}

-- Reset Wazon to spawn point and reset AI
local resetWazon = function(mob)
    DespawnMob(mob:getID())
    mob:setPos(-381.1,-12,398,1)
    mob:resetAI()
end

entity.onMobSpawn = function(mob)
    mob:setAllegiance(xi.allegiance.PLAYER)
end

entity.onMobTrigger = function(player, mob)
    -- Begin, Wazon!
    if player:getCharVar("quest[2][88]Prog") == 1 then
        local party = player:getParty()

        for _, v in ipairs(party) do
            if v:getZone() == player:getZone() then
                v:setCharVar("quest[2][88]Prog", 2)
            end
        end
        mob:messageText(mob, ID.text.TIME_LIMIT, 30)
        mob:setLocalVar("run", 1)
    end

    if player:getCharVar("quest[2][88]Prog") == 2 then
        -- Stop, Wazon!
        if mob:getLocalVar("run") == 1 then
            mob:setLocalVar("run", 0)
            mob:messageText(mob, ID.text.WHATS_WRONG)

        -- Run, Wazon!
        elseif mob:getLocalVar("run") == 0 then
            mob:setLocalVar("run", 1)
            mob:messageText(mob, ID.text.LETS_GO)

        -- We won, Wazon!
        elseif mob:getLocalVar("win") == 1 then
            mob:messageText(mob, ID.text.I_THANK_YOU)
            if not player:hasKeyItem(xi.ki.COMPLETION_CERTIFICATE) then
                -- Setting var to 3 disallows player from interacting with this quest any further
                player:setCharVar("quest[2][88]Prog", 3)
                player:addKeyItem(player, xi.ki.COMPLETION_CERTIFICATE)
            end
        end
    end
end

entity.onMobFight = function(mob, target)
    mob:setLocalVar("run", 0)
end

entity.onMobRoam = function(mob)
    if mob:atPoint(xi.path.last(route)) and mob:getLocalVar("win") == 0 then
        mob:setLocalVar("run", 3)
        mob:setLocalVar("win", 1)
        mob:timer(30000, function(mobArg)
            mob:messageText(mob, ID.text.BYE_BYE)
            resetWazon(mob)
        end)

        -- Time up case
        elseif mob:getZone():getLocalVar("timer") < os.time() then
            -- resetWazon(mob)

        -- Run case
        elseif mob:getLocalVar("run") == 1 then
            mob:pathThrough(route, xi.path.flag.PATROL)
        end
end

entity.onMobDeath = function(mob)
    mob:messageText(mob, ID.text.LOST_SIGHT)
    resetWazon(mob)
end

return entity
