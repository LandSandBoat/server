-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Cletae
-- Guild Merchant NPC: Leathercrafting Guild
-- !pos -189.142 -8.800 14.449 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Flyers_For_Regine needs to be reviewed.
    local flyerForRegine = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)

    if flyerForRegine == 1 then
        if npcUtil.tradeHasExactly(trade, 532) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

entity.onTrigger = function(player, npc)
    local guildSkillId = xi.skill.LEATHERCRAFT
    local stock = xi.shop.generalGuildStock[guildSkillId]

    xi.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.CLETAE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
