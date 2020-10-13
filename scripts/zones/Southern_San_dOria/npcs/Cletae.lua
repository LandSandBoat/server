-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Cletae
-- Guild Merchant NPC: Leathercrafting Guild
-- !pos -189.142 -8.800 14.449 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/shop")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    -- Flyers_For_Regine needs to be reviewed.
    local FlyerForRegine = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)

    if FlyerForRegine == 1 then
        if npcUtil.tradeHasExactly(trade, 532) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

function onTrigger(player, npc)
    local guildSkillId = tpz.skill.LEATHERCRAFT
    local stock = tpz.shop.generalGuildStock[guildSkillId]
    tpz.shop.generalGuild(player, stock, guildSkillId)
    player:showText(npc, ID.text.CLETAE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
