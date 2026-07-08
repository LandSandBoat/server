-----------------------------------
-- Borghertz's Dragon Hands
-----------------------------------
-- Log ID: 3, Quest ID: 57
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_DRAGON_HANDS,
    handAFId          = xi.item.DRACHEN_FINGER_GAUNTLETS,
    requiredLogId     = xi.questLog.SANDORIA,
    requiredQuestId   = xi.quest.id.sandoria.CHASING_QUOTAS,
    requiredJobId     = xi.job.DRG,
    oldGauntletZoneId = xi.zone.THE_BOYAHDA_TREE,
    optionalZoneId1   = xi.zone.IFRITS_CAULDRON,
    optionalZoneId2   = xi.zone.QUICKSAND_CAVES,
    optionalArtifact1 = xi.item.DRACHEN_MAIL,
    optionalArtifact2 = xi.item.DRACHEN_GREAVES,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
