-----------------------------------
-- Borghertz's Loyal Hands
-----------------------------------
-- Log ID: 3, Quest ID: 55
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_LOYAL_HANDS,
    handAFId          = xi.item.MYOCHIN_KOTE,
    requiredLogId     = xi.questLog.OUTLANDS,
    requiredQuestId   = xi.quest.id.outlands.YOMI_OKURI,
    requiredJobId     = xi.job.SAM,
    oldGauntletZoneId = xi.zone.KUFTAL_TUNNEL,
    optionalZoneId1   = xi.zone.QUICKSAND_CAVES,
    optionalZoneId2   = xi.zone.TEMPLE_OF_UGGALEPIH,
    optionalArtifact1 = xi.item.MYOCHIN_HAIDATE,
    optionalArtifact2 = xi.item.MYOCHIN_DOMARU,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
