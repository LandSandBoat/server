-----------------------------------
-- Area: Windurst Woods
--  NPC: Nikkoko
-- Type: Clothcraft Image Support
-- !pos -32.810 -3.25 -113.680 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 3)
    local SkillCap = getCraftSkillCap(player, tpz.skill.CLOTHCRAFT)
    local SkillLevel = player:getSkillLevel(tpz.skill.CLOTHCRAFT)

    if guildMember == 1 then
        if not player:hasStatusEffect(tpz.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(10014, SkillCap, SkillLevel, 1, 511, player:getGil(), 0, 4095, 0) -- p1 = skill level
        else
            player:startEvent(10014, SkillCap, SkillLevel, 1, 511, player:getGil(), 7101, 4095, 0)
        end
    else
        player:startEvent(10014) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10014 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 1)
        player:addStatusEffect(tpz.effect.CLOTHCRAFT_IMAGERY, 1, 0, 120)
    end
end
