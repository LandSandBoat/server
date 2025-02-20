-- Zone: PsoXja (9)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------

local psoXjaGlobal = {}
--[[..............................................................................................
    thief attempting to pick a lock on stone gate NPC during 5-3T1: Spiral
    correctSideOfDoor (boolean) true if player is trading from the near(gargoyle)-side of the gate
    ..............................................................................................]]
psoXjaGlobal.attemptPickLock = function(player, npc, trade, correctSideOfDoor)
    local isThf = player:getMainJob() == xi.job.THF
    local tradedLockTool = trade:getItemCount() == 1 and (
        trade:hasItemQty(xi.item.SKELETON_KEY, 1) or
        trade:hasItemQty(xi.item.LIVING_KEY, 1) or
        trade:hasItemQty(xi.item.SET_OF_THIEFS_TOOLS, 1)
    )

    if
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        correctSideOfDoor and
        isThf and
        tradedLockTool
    then
        local offset = npc:getID() - ID.npc.STONE_DOOR_OFFSET
        local gargoyle = ID.mob.GARGOYLE_OFFSET + offset

        if GetMobByID(gargoyle):isSpawned() then
            player:messageSpecial(ID.text.DOOR_LOCKED)
        else
            if math.random(1, 100) <= 50 then
                npc:messageName(ID.text.DISCOVER_DISARM_FAIL, player)
                SpawnMob(gargoyle):updateClaim(player)
            else
                npc:messageName(ID.text.DISCOVER_DISARM_SUCCESS, player)
                npc:openDoor(30)
            end

            player:tradeComplete()
        end
    end
end

--[[..............................................................................................
    player clicking on stone gate NPC during 5-3T1: Spiral
    correctSideOfDoor (boolean) true if player is clicking from the near(gargoyle)-side of gate
    ..............................................................................................]]
psoXjaGlobal.attemptOpenDoor = function(player, npc, correctSideOfDoor)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        if correctSideOfDoor then
            local offset = npc:getID() - ID.npc.STONE_DOOR_OFFSET
            local gargoyle = ID.mob.GARGOYLE_OFFSET + offset

            if GetMobByID(gargoyle):isSpawned() then
                player:messageSpecial(ID.text.DOOR_LOCKED)
            else
                if math.random(1, 10) <= 9 then -- Spawn Gargoyle
                    npc:messageName(ID.text.TRAP_ACTIVATED, player)
                    SpawnMob(gargoyle):updateClaim(player)
                else
                    npc:messageName(ID.text.TRAP_FAILS, player)
                    npc:openDoor(30)
                end
            end
        else
            player:startEvent(26) -- return to beginning of spiral
        end
    end
end

psoXjaGlobal.cs26EventFinish = function(player, csid, option)
    if csid == 26 and option == 1 then
        player:setPos(260, -0.25, -20, 254, 111)
    end
end

return psoXjaGlobal
