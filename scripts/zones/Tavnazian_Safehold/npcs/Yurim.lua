-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Yurim
-- !pos 83.697 -25.000 3.250 26
-----------------------------------
---@type TNpcEntity
local entity = {}

local nosTrades =
{
    [xi.item.KARIN_OBI] =
    {
        hint = 1,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.RED_CHIP,
        },
        organs =
        {
            { xi.item.PHUABO_ORGAN,              7 },
            { xi.item.XZOMIT_ORGAN,              3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.HYORIN_OBI] =
    {
        hint = 2,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.CLEAR_CHIP,
        },
        organs =
        {
            { xi.item.XZOMIT_ORGAN,              7 },
            { xi.item.PHUABO_ORGAN,              3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.FURIN_OBI] =
    {
        hint = 3,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.GREEN_CHIP,
        },
        organs =
        {
            { xi.item.AERN_ORGAN,                7 },
            { xi.item.HPEMDE_ORGAN,              3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.DORIN_OBI] =
    {
        hint = 4,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.YELLOW_CHIP,
        },
        organs =
        {
            { xi.item.HPEMDE_ORGAN,              7 },
            { xi.item.AERN_ORGAN,                3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.RAIRIN_OBI] =
    {
        hint = 5,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.PURPLE_CHIP,
        },
        organs =
        {
            { xi.item.PHUABO_ORGAN,              7 },
            { xi.item.HPEMDE_ORGAN,              3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.SUIRIN_OBI] =
    {
        hint = 6,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.BLUE_CHIP,
        },
        organs =
        {
            { xi.item.HPEMDE_ORGAN,              7 },
            { xi.item.PHUABO_ORGAN,              3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.KORIN_OBI] =
    {
        hint = 7,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.WHITE_CHIP,
        },
        organs =
        {
            { xi.item.XZOMIT_ORGAN,              7 },
            { xi.item.AERN_ORGAN,                3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.ANRIN_OBI] =
    {
        hint = 8,
        base =
        {
            xi.item.SILVER_OBI,
            xi.item.BLACK_CHIP,
        },
        organs =
        {
            { xi.item.AERN_ORGAN,                7 },
            { xi.item.XZOMIT_ORGAN,              3 },
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 3 },
        },
    },

    [xi.item.FLAME_GORGET] =
    {
        hint = 9,
        base =
        {
            xi.item.GORGET,
            xi.item.RED_CHIP,
        },
        organs =
        {
            { xi.item.PHUABO_ORGAN, 10 },
            { xi.item.XZOMIT_ORGAN,  5 },
            { xi.item.YOVRA_ORGAN,   1 },
        },
    },

    [xi.item.SNOW_GORGET] =
    {
        hint = 10,
        base =
        {
            xi.item.GORGET,
            xi.item.CLEAR_CHIP,
        },
        organs =
        {
            { xi.item.PHUABO_ORGAN, 10 },
            { xi.item.AERN_ORGAN,    5 },
            { xi.item.YOVRA_ORGAN,   1 },
        },
    },

    [xi.item.BREEZE_GORGET] =
    {
        hint = 11,
        base =
        {
            xi.item.GORGET,
            xi.item.GREEN_CHIP,
        },
        organs =
        {
            { xi.item.PHUABO_ORGAN, 10 },
            { xi.item.HPEMDE_ORGAN,  5 },
            { xi.item.YOVRA_ORGAN,   1 },
        },
    },

    [xi.item.SOIL_GORGET] =
    {
        hint = 12,
        base =
        {
            xi.item.GORGET,
            xi.item.YELLOW_CHIP,
        },
        organs =
        {
            { xi.item.XZOMIT_ORGAN, 10 },
            { xi.item.AERN_ORGAN,    5 },
            { xi.item.YOVRA_ORGAN,   1 },
        },
    },

    [xi.item.THUNDER_GORGET] =
    {
        hint = 13,
        base =
        {
            xi.item.GORGET,
            xi.item.PURPLE_CHIP,
        },
        organs =
        {
            { xi.item.XZOMIT_ORGAN, 10 },
            { xi.item.HPEMDE_ORGAN,  5 },
            { xi.item.YOVRA_ORGAN,   1 },
        },
    },

    [xi.item.AQUA_GORGET]  =
    {
        hint = 14,
        base =
        {
            xi.item.GORGET,
            xi.item.BLUE_CHIP,
        },
        organs =
        {
            { xi.item.AERN_ORGAN,   10 },
            { xi.item.HPEMDE_ORGAN,  5 },
            { xi.item.YOVRA_ORGAN,   1 },
        },
    },

    [xi.item.LIGHT_GORGET] =
    {
        hint = 15,
        base =
        {
            xi.item.GORGET,
            xi.item.WHITE_CHIP,
        },
        organs =
        {
            { xi.item.AERN_ORGAN,   7 },
            { xi.item.PHUABO_ORGAN, 3 },
            { xi.item.HPEMDE_ORGAN, 3 },
            { xi.item.YOVRA_ORGAN,  2 },
        },
    },

    [xi.item.SHADOW_GORGET] =
    {
        hint = 16,
        base =
        {
            xi.item.GORGET,
            xi.item.BLACK_CHIP,
        },
        organs =
        {
            { xi.item.HPEMDE_ORGAN, 7 },
            { xi.item.PHUABO_ORGAN, 3 },
            { xi.item.AERN_ORGAN,   3 },
            { xi.item.YOVRA_ORGAN,  2 },
        },
    },

    [xi.item.SANATIVE_EARRING] =
    {
        hint = 17,
        base =
        {
            xi.item.SILVER_EARRING,
            xi.item.WHITE_CHIP,
        },
        organs =
        {
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 5 },
            { xi.item.EUVHI_ORGAN,               5 },
        },
    },

    [xi.item.RELAXING_EARRING] =
    {
        hint = 17,
        base =
        {
            xi.item.SILVER_EARRING,
            xi.item.BLACK_CHIP,
        },
        organs =
        {
            { xi.item.SAMPLE_OF_LUMINIAN_TISSUE, 5 },
            { xi.item.EUVHI_ORGAN,               5 },
        },
    },
}

entity.onTrade = function(player, npc, trade)
    local nameOfScience  = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE)
    local itemInProgress = player:getCharVar('NAME_OF_SCIENCE_target')

    if
        itemInProgress > 0 and
        npcUtil.tradeHas(trade, nosTrades[itemInProgress].organs)
    then
        player:startEvent(529, xi.item.GORGET, xi.item.SILVER_EARRING, xi.item.SILVER_OBI)
    elseif
        (nameOfScience == xi.questStatus.QUEST_ACCEPTED or nameOfScience == xi.questStatus.QUEST_COMPLETED) and
        npcUtil.tradeHas(trade, xi.item.APPLE_PIE) and
        itemInProgress > 0
    then
        -- apple pie hint
        player:startEvent(531, xi.item.APPLE_PIE, 0, nosTrades[itemInProgress].hint)
    elseif
        (nameOfScience == xi.questStatus.QUEST_ACCEPTED or nameOfScience == xi.questStatus.QUEST_COMPLETED) and
        itemInProgress == 0
    then
        for k, v in pairs(nosTrades) do
            if npcUtil.tradeHas(trade, v.base) then
                player:setCharVar('NAME_OF_SCIENCE_target', k)
                player:startEvent(526, unpack(v.base))
                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    -- IN THE NAME OF SCIENCE
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) then
        local nameOfScience  = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE)
        local itemInProgress = player:getCharVar('NAME_OF_SCIENCE_target')

        if nameOfScience == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(524, xi.item.SILVER_OBI, xi.item.SILVER_EARRING, xi.item.GORGET)
        elseif
            (nameOfScience == xi.questStatus.QUEST_ACCEPTED or nameOfScience == xi.questStatus.QUEST_COMPLETED) and
            itemInProgress == 0
        then
            player:startEvent(525, xi.item.SILVER_OBI, xi.item.SILVER_EARRING, xi.item.GORGET)
        elseif
            nameOfScience == xi.questStatus.QUEST_ACCEPTED or
            nameOfScience == xi.questStatus.QUEST_COMPLETED
        then
            if math.random(1, 100) <= 30 then
                player:startEvent(532, unpack(nosTrades[itemInProgress].base))
            else
                player:startEvent(528, unpack(nosTrades[itemInProgress].base))
            end
        end

    -- STANDARD DIALOG
    -- TODO: This is not a true default action, and needs to be verified for when this begins to be displayed
    -- else
    --    player:startEvent(519)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 524 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE)
    elseif csid == 531 then
        player:confirmTrade()
    elseif csid == 526 then
        player:confirmTrade()
    elseif csid == 529 then
        local itemInProgress = player:getCharVar('NAME_OF_SCIENCE_target')
        if npcUtil.completeQuest(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.IN_THE_NAME_OF_SCIENCE, { item = itemInProgress, var = { 'NAME_OF_SCIENCE_target' } }) then
            player:confirmTrade()
        end
    end
end

return entity
