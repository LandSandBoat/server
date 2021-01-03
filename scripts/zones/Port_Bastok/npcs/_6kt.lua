-----------------------------------
-- Area: Port Bastok
--  NPC: Drawbridge
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onSpawn(npc)
    --Triggers to open the drawbridge
    npc:addPeriodicTrigger(0, 360, 4)
    npc:addPeriodicTrigger(2, 360, 80)

    --Triggers to close the drawbridge
    npc:addPeriodicTrigger(1, 360, 9)
    npc:addPeriodicTrigger(3, 360, 85)

    --Triggers to re-open the walkway
    npc:addPeriodicTrigger(4, 360, 13)
    npc:addPeriodicTrigger(5, 360, 89)
end

function onTimeTrigger(npc, triggerID)
--npc is the moghouse-side door to the bridge
    local upperDoor = GetNPCByID(npc:getID() - 1)
    local bridge = GetNPCByID(npc:getID() - 2)

    if npc == nil or upperDoor == nil or bridge == nil then
        error("Drawbridge NPC failure")
        return
    end

    if (triggerID == 0 or triggerID == 2) then
        --drawbridge needs to open
        local players = npc:getZone():getPlayers()

        --If a player is on the bridge, kick them off
        for _, player in pairs(players) do
            if player:getPlayerRegionInZone() == 2 then
                player:startEvent(70)
            end
        end

        bridge:updateToEntireZone(tpz.status.NORMAL, tpz.animation.CLOSE_DOOR, true)
        upperDoor:setAnimation(tpz.animation.CLOSE_DOOR)
        npc:setAnimation(tpz.animation.CLOSE_DOOR)

    elseif (triggerID == 1 or triggerID == 3) then
        --drawbridge needs to close
        bridge:updateToEntireZone(tpz.status.NORMAL, tpz.animation.OPEN_DOOR, true)

    elseif (triggerID == 4 or triggerID == 5) then
        --drawbridge has finished closing, reopen entry to walkers
        upperDoor:setAnimation(tpz.animation.OPEN_DOOR)
        npc:setAnimation(tpz.animation.OPEN_DOOR)
    end

end
