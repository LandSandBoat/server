-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Stone Picture Frame
-- Notes: Opens door to Den of Rancor using Painbrush of Souls
-- !pos -52.239 -2.089 10.000 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()

    if X < -60 then
        if Z < -6 then -- SW frame
            if player:hasKeyItem(tpz.ki.FINAL_FANTASY) then
                player:startEvent(50, tpz.ki.FINAL_FANTASY)
            else
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 31) -- This is a frame for a painting.
            end
        elseif Z < 5 then
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 14) -- It is a picture of an old mage carrying a staff.
        else
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 13) -- It is a picture of a small group of three men and women.
        end
    else
        if Z <-5 then -- SE picture
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 12) -- It is a painting of a beautiful landscape.
        elseif Z > -5 and Z < 5 then
            if GetNPCByID(ID.npc.DOOR_TO_RANCOR):getAnimation() == tpz.anim.OPEN_DOOR then
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 23, tpz.ki.PAINTBRUSH_OF_SOULS) -- The <KEY_ITEM> begins to twitch. The canvas is graced with the image from your soul.
            elseif player:hasKeyItem(tpz.ki.PAINTBRUSH_OF_SOULS) and X >= -53.2 and Z <= 0.1 and Z >= -0.1 then -- has paintbrush of souls + close enough
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 17, tpz.ki.PAINTBRUSH_OF_SOULS)
                player:setCharVar("started_painting", os.time())
                player:startEvent(60, tpz.ki.PAINTBRUSH_OF_SOULS)
            elseif player:hasKeyItem(tpz.ki.PAINTBRUSH_OF_SOULS) then
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 15, tpz.ki.PAINTBRUSH_OF_SOULS)
            else
                player:messageSpecial(ID.text.PAINTBRUSH_OFFSET, tpz.ki.PAINTBRUSH_OF_SOULS) -- When the paintbrush of souls projects the deepest, darkest corner of your soul...
            end
        else
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 11) -- It is a painting of a sublime-looking woman.
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 50 then
        -- Soon !
    elseif csid == 60 then
        local time_elapsed = os.time() - player:getCharVar("started_painting")
        if time_elapsed >= 30 then
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 22) -- You succeeded in projecting the image in your soul to the blank canvas. The door to the Rancor Den has opened!<Prompt>
            GetNPCByID(ID.npc.DOOR_TO_RANCOR):openDoor(45) -- Open the door to Den of Rancor for 45 sec
        else
            player:messageSpecial(ID.text.PAINTBRUSH_OFFSET + 21) -- You were unable to fill the canvas with an image from your soul.
        end
        player:setCharVar("started_painting", 0)
    end
end

return entity
