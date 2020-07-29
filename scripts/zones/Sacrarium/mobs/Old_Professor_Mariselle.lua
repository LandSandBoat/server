-----------------------------------
-- Area: Sacrarium
--  Mob: Old Professor Mariselle
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onMobFight(mob, target)

    local OP_Mariselle = mob:getID()

    -- Summons a pupil every 30 seconds.
    -- TODO: Casting animation for summons. When he spawns them isn't retail accurate.
    -- TODO: Make him and the clones teleport around the room every 30s

    if (mob:getBattleTime() % 30 < 3 and mob:getBattleTime() > 3) then
        local X = mob:getXPos()
        local Y = mob:getYPos()
        local Z = mob:getZPos()

        for i = OP_Mariselle+1, OP_Mariselle+2 do
            local m = GetMobByID(i)
            if not m:isSpawned() then
                m:spawn()
                m:updateEnmity(target)
                m:setPos(X + 1, Y, Z + 1) -- Set pupil x and z position +1 from Mariselle
                return
            end
        end
    end

end

function onMobDeath(mob, player, isKiller)

    local OP_Mariselle = mob:getID()

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and player:getCharVar("PromathiaStatus") == 3 and  player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY)==false) then
        player:setCharVar("PromathiaStatus", 4)
    end

    -- Set random variable for determining Old Prof. Mariselle's next spawn location
    local rand = math.random((2), (7))
    SetServerVariable("Old_Prof_Spawn_Location", rand)

end

function onMobDespawn( mob )

    local OP_Mariselle = mob:getID()

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    -- Set random variable for determining Old Prof. Mariselle's next spawn location
    local rand = math.random((2), (7))
    SetServerVariable("Old_Prof_Spawn_Location", rand)

end
