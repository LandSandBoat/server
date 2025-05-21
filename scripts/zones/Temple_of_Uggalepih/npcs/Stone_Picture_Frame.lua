-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Stone Picture Frame
-- Notes: Opens door to Den of Rancor using Painbrush of Souls
-- !pos -52.239 -2.089 10.000 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()

    if xPos < -60 then
        if zPos < -6 then -- SW frame
            if player:hasKeyItem(xi.ki.FINAL_FANTASY) then
                player:startEvent(50, xi.ki.FINAL_FANTASY)
            else
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 31) -- This is a frame for a painting.
            end
        elseif zPos < 5 then
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 14) -- It is a picture of an old mage carrying a staff.
        else
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 13) -- It is a picture of a small group of three men and women.
        end
    else
        if zPos < -5 then -- SE picture
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 12) -- It is a painting of a beautiful landscape.
        elseif zPos > -5 and zPos < 5 then
            if GetNPCByID(ID.npc.DOOR_TO_RANCOR):getAnimation() == xi.anim.OPEN_DOOR then
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 23, xi.ki.PAINTBRUSH_OF_SOULS) -- The <KEY_ITEM> begins to twitch. The canvas is graced with the image from your soul.
            elseif
                player:hasKeyItem(xi.ki.PAINTBRUSH_OF_SOULS) and
                xPos >= -53.2 and
                zPos <= 0.1 and
                zPos >= -0.1
            then
                -- has paintbrush of souls + close enough
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 17, xi.ki.PAINTBRUSH_OF_SOULS)
                player:setCharVar('started_painting', os.time())
                player:startEvent(60, xi.ki.PAINTBRUSH_OF_SOULS)
            elseif player:hasKeyItem(xi.ki.PAINTBRUSH_OF_SOULS) then
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 15, xi.ki.PAINTBRUSH_OF_SOULS)
            else
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET, xi.ki.PAINTBRUSH_OF_SOULS) -- When the paintbrush of souls projects the deepest, darkest corner of your soul...
            end
        else
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 11) -- It is a painting of a sublime-looking woman.
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 50 then
        -- Soon !
    elseif csid == 60 then
        local timeElapsed = os.time() - player:getCharVar('started_painting')
        if timeElapsed >= 30 then
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 22) -- You succeeded in projecting the image in your soul to the blank canvas. The door to the Rancor Den has opened!<Prompt>
            GetNPCByID(ID.npc.DOOR_TO_RANCOR):openDoor(45) -- Open the door to Den of Rancor for 45 sec
        else
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 21) -- You were unable to fill the canvas with an image from your soul.
        end

        player:setCharVar('started_painting', 0)
    end
end

return entity
