-----------------------------------
-- Area: Windurst Woods
--  NPC: Ronana
-- Type: Bonecraft Image Support
-- !pos -1.540 -6.25 -144.517 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 2)
    local SkillCap = getCraftSkillCap(player, tpz.skill.BONECRAFT)
    local SkillLevel = player:getSkillLevel(tpz.skill.BONECRAFT)

    if guildMember == 1 then
        if not player:hasStatusEffect(tpz.effect.BONECRAFT_IMAGERY) then
            player:startEvent(10019, SkillCap, SkillLevel, 1, 511, player:getGil(), 0, 36408, 0)
        else
            player:startEvent(10019, SkillCap, SkillLevel, 1, 511, player:getGil(), 7081, 36408, 0)
        end
    else
        player:startEvent(10019) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10019 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 1)
        player:addStatusEffect(tpz.effect.BONECRAFT_IMAGERY, 1, 0, 120)
    end
end
