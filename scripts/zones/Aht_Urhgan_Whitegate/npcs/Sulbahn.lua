-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sulbahn
-- Type: Alchemy Adv. Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local guildMember = isGuildMember(player, 1)

    if guildMember == 1 then
        if npcUtil.tradeHas(trade, 2184) then
            if player:hasStatusEffect(tpz.effect.ALCHEMY_IMAGERY) == false then
                player:confirmTrade()
                player:startEvent(637, 17160, 1, 19405, 21215, 30030, 0, 7, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 1)
    local SkillLevel = player:getSkillLevel(tpz.skill.ALCHEMY)

    if guildMember == 1 then
        player:startEvent(636, 2, SkillLevel, 0, 511, 0, 0, 7, 2184)
    else
        player:startEvent(636, 0, 0, 0, 0, 0, 0, 7, 0) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 637 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 7, 0)
        player:addStatusEffect(tpz.effect.ALCHEMY_IMAGERY, 3, 0, 480)
    end
end
