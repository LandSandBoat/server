-----------------------------------
-- Area: Port Bastok
--  NPC: Clarion Star
-- Trust NPC
-- !pos 81.478 7.500 -24.169 236
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.trust.onTradeCipher(player, trade, 437, 457, 458)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 437 or csid == 458 then
        local spellID = player:getLocalVar('TradingTrustCipher')
        player:setLocalVar('TradingTrustCipher', 0)
        player:addSpell(spellID, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, spellID)
        player:tradeComplete()
    end
end

return entity
