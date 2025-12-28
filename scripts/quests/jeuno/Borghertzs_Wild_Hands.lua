-----------------------------------
-- Borghertz's Wild Hands
-----------------------------------
-- Log ID: 3, Quest ID: 52
-- Torch         : !pos  63 -24  21 161
-- Guslam        : !pos  -5   1  48 244
-- Deadly Minnow : !pos  -5   1  48 244
-- Yin Pocanakhu : !pos  35   4 -43 245
-- qm1           : !pos -51   8  -4 246
-----------------------------------
require('scripts/quests/jeuno/helpers')
-----------------------------------

local params =
{
    questId           = xi.quest.id.jeuno.BORGHERTZS_WILD_HANDS,
    handAFId          = xi.item.BEAST_GLOVES,
    requiredLogId     = xi.questLog.JEUNO,
    requiredQuestId   = xi.quest.id.jeuno.SCATTERED_INTO_SHADOW,
    requiredJobId     = xi.job.BST,
    oldGauntletZoneId = xi.zone.CRAWLERS_NEST,
    optionalZoneId1   = xi.zone.BEADEAUX,
    optionalZoneId2   = xi.zone.GARLAIGE_CITADEL,
    optionalArtifact1 = xi.item.BEAST_JACKCOAT,
    optionalArtifact2 = xi.item.BEAST_HELM,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
