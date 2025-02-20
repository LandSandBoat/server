-----------------------------------
-- Zone: RoMaeve (122)
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    local newPosition = npcUtil.pickNewPosition(ID.npc.BASTOK_7_1_QM, ID.npc.BASTOK_7_1_QM_POS, true)
    GetNPCByID(ID.npc.BASTOK_7_1_QM):setPos(newPosition.x, newPosition.y, newPosition.z)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-0.008, -33.595, 123.478, 62)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    local vanadielHour = VanadielHour()
    local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
    local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)

    -- Make Ro'Maeve come to life between 6pm and 6am during a full moon
    if moongate1 and moongate2 then
        if IsMoonFull() and (vanadielHour >= 18 or vanadielHour < 6) then
            if moongate1:getLocalVar('romaeveActive') == 0 then
                -- Loop over the affected NPCs: Moongates, bridges and fountain
                for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
                    GetNPCByID(i):setAnimation(xi.anim.OPEN_DOOR) -- Open them
                end

                moongate2:setUntargetable(true)
                moongate1:setUntargetable(true)
                moongate1:setLocalVar('romaeveActive', 1) -- Make this loop unavailable after firing
            end

        -- Clean up at 6am
        elseif vanadielHour == 6 then
            if moongate1:getLocalVar('romaeveActive') == 1 then
                for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
                    GetNPCByID(i):setAnimation(xi.anim.CLOSE_DOOR)
                end

                moongate2:setUntargetable(false)
                moongate1:setUntargetable(false)
                moongate1:setLocalVar('romaeveActive', 0) -- Make loop available again
            end
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
