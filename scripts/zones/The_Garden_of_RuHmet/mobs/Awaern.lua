-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'aern
-- Note: PH for Ix'Aern DRK and DRG
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
-----------------------------------

function onMobSpawn(mob)
    local IxAernDRG_PH = GetServerVariable("[SEA]IxAernDRG_PH") -- Should be be the ID of the mob that spawns the actual PH

    -- Pick the Ix'Aern (DRG) PH if the server doesn't have one, and the if the actual PH/NM isn't up. Then, set it.
    if not GetMobByID(ID.mob.IXAERN_DRG):isSpawned() and GetServerVariable("[SEA]IxAernDRG_PH") == 0 then  -- This should be cleared when the mob is killed.
        local groups = ID.mob.AWAERN_DRG_GROUPS
        IxAernDRG_PH = groups[math.random(1, #groups)] + math.random(0, 2) -- The 4th mobid in each group is a pet. F that son
        SetServerVariable("[SEA]IxAernDRG_PH", IxAernDRG_PH)
    end
end

function onMobDeath(mob, player, isKiller)
    -- Ix'Aern DRK animosity mechanic
    if (isKiller) then
        local qm2 = GetNPCByID(ID.npc.IXAERN_DRK_QM)
        local hatedPlayer = qm2:getLocalVar("hatedPlayer")
        local isInTime = qm2:getLocalVar("hateTimer") > os.time()

        if (qm2:getStatus() ~= tpz.status.DISAPPEAR and (hatedPlayer == 0 or not isInTime)) then
            -- if hated player took too long, reset
            if (hatedPlayer ~= 0) then
                qm2:setLocalVar("hatedPlayer", 0)
                qm2:setLocalVar("hateTimer", 0)
            end

            -- if aern belongs to QM group, chance for sheer animosity
            local position = GetNPCByID(ID.npc.IXAERN_DRK_QM):getLocalVar("position")
            local currentMobID = mob:getID()
            if (currentMobID >= ID.mob.AWAERN_DRK_GROUPS[position] and currentMobID <= ID.mob.AWAERN_DRK_GROUPS[position] + 2) then
                if (math.random(1, 8) == 1) then
                    qm2:setLocalVar("hatedPlayer", player:getID())
                    qm2:setLocalVar("hateTimer", os.time() + 600) -- player with animosity has 10 minutes to touch QM
                    player:messageSpecial(ID.text.SHEER_ANIMOSITY)
                end
            end
        end
    end

end

function onMobDespawn(mob)
    local currentMobID = mob:getID()

    -- Ix'Aern (DRG) Placeholder mobs
    local IxAernDRG_PH = GetServerVariable("[SEA]IxAernDRG_PH") -- Should be be the ID of the mob that spawns the actual PH.

    -- If the mob killed was the randomized PH, then Ix'Aern (DRG) in the specific spot, unclaimed and not aggroed.
    if (IxAernDRG_PH == currentMobID) then
        -- Select spawn location based on ID
        local offset = currentMobID - ID.mob.AWAERN_DRG_GROUPS[1]
        if (offset >=0 and offset <=3) then
            GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-520, 5, -520, 225) -- Bottom Left
        elseif (offset >= 4 and offset <= 7) then
            GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-520, 5, -359, 30) -- Top Left
        elseif (offset >= 8 and offset <= 11) then
            GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-319, 5, -359, 95) -- Top Right
        elseif (offset >= 12 and offset <= 15) then
            GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-319, 5, -520, 156) -- Bottom Right
        end
        SpawnMob(ID.mob.IXAERN_DRG)
        SetServerVariable("[SEA]IxAernDRG_PH", 0) -- Clear the variable because it is spawned!
    end

end
