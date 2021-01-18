-----------------------------------
-- Area: Port Bastok
--  NPC: Steel Bones
-- Standard Info NPC
-- Involved in Quest: Guest of Hauteur
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local GuestofHauteur = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.GUEST_OF_HAUTEUR)
    local itemEquipped = player:getEquipID(tpz.slot.MAIN)

    if GuestofHauteur == QUEST_ACCEPTED and player:getCharVar("GuestofHauteur_Event") ~= 1 and (itemEquipped == 17045 or itemEquipped == 17426) then -- Maul / Replica Maul
        player:startEvent(57)
    else
        player:startEvent(29)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if csid == 57 then
        player:setCharVar("GuestofHauteur_Event", 1)
        player:addKeyItem(tpz.ki.LETTERS_FROM_DOMIEN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTERS_FROM_DOMIEN)
    end

end

return entity
