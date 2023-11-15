-----------------------------------
-- ID: 16607
-- Chaosbringer
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(player, item)
    player:setCharVar('ChaosbringerKills', 0)
end

itemObject.onItemEquip = function(player, item)
    player:addListener("ATTACK", "CHAOSBRINGER_KILLS", function(playerAttkListener, mobAttkListener)
        if mobAttkListener:getLocalVar("CBListenerApplied") == 0 then
            mobAttkListener:addListener("ATTACKED", "VALID_KILL", function(mobAttkedListener, playerAttkedListener, action)
                mobAttkedListener:setLocalVar("CBListenerApplied", 1)
                if
                    playerAttkedListener:isPC() and
                    playerAttkedListener:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) >= QUEST_ACCEPTED and
                    playerAttkedListener:getEquipID(xi.slot.MAIN) == xi.items.CHAOSBRINGER and
                    mobAttkedListener:getHP() == 0
                then
                    playerAttkedListener:incrementCharVar("ChaosbringerKills", 1)
                end
            end)
        end
    end)
end

itemObject.onItemUnequip = function(player, item)
    player:removeListener("CHAOSBRINGER_KILLS")
end

return itemObject
