-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Tateeya
-- Automaton Attachment Unlocks
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local tradeStatus = player:getCharVar('TateeyaTradeStatus')
    local automatonName = player:getAutomatonName()
    if tradeStatus == 1 then
        for i = 0, 7 do
            local subid = trade:getItemSubId(i)
            if subid >= 0x2000 and subid < 0x2800 then
                if player:unlockAttachment(subid) then
                    player:setCharVar('TateeyaUnlock', subid)
                    player:startEventString(651, automatonName, automatonName, automatonName, automatonName, subid) --unlock attachment event
                    if trade:confirmSlot(i) then
                        player:confirmTrade()
                    end
                else
                    player:startEvent(652) --already unlocked event
                end

                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local tradeStatus = player:getCharVar('TateeyaTradeStatus')
    local automatonName = player:getAutomatonName()
    if tradeStatus == 0 then
        if player:getMainJob() == xi.job.PUP then
            player:startEventString(650, automatonName, automatonName, automatonName, automatonName) --trade me to unlock attachments
        else
            player:startEvent(258) --default no PUP CS
        end
    else
        player:startEventString(650, automatonName, automatonName, automatonName, automatonName, 1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 650 then --unlocking attachments explanation
        player:setCharVar('TateeyaTradeStatus', 1)
    elseif csid == 651 then
        local subid = player:getCharVar('TateeyaUnlock')
        player:messageSpecial(ID.text.AUTOMATON_ATTACHMENT_UNLOCK, subid)
        player:setCharVar('TateeyaUnlock', 0)
    end
end

return entity
