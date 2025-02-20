-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h8 (Sapphire Column)
-- Notes: Mechanism for Altepa Gate
-- !pos -499 10 224 125
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() ~= xi.anim.OPEN_DOOR then
        npc:updateToEntireZone(xi.status.NORMAL, xi.anim.OPEN_DOOR)
        local column = GetNPCByID(npc:getID() - 4)
        if column then
            column:updateToEntireZone(xi.status.NORMAL, xi.anim.OPEN_DOOR)
        end
    else
        player:messageSpecial(ID.text.DOES_NOT_RESPOND)
    end

    if
        GetNPCByID(ID.npc.ALTEPA_GATE + 5):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 6):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 7):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(ID.npc.ALTEPA_GATE + 8):getAnimation() == xi.anim.OPEN_DOOR
    then
        local openTime = math.random(15, 30) * 1000 * 60

        for i = ID.npc.ALTEPA_GATE, ID.npc.ALTEPA_GATE + 8 do
            local door = GetNPCByID(i)

            -- openDoor used to (read: a decade ish ago before Sol) allow calls to doors already open and set a timer to close them
            -- This snippet reproduces this behavor AND updates everyone in the zone on the status of the doors.
            if door then
                door:updateToEntireZone(xi.status.NORMAL, xi.anim.OPEN_DOOR)
                door:timer(openTime, function(doorArg)
                    doorArg:updateToEntireZone(xi.status.NORMAL, xi.anim.CLOSE_DOOR)
                end)
            end
        end
    end
end

return entity
