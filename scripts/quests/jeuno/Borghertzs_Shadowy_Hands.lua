-----------------------------------
-- Borghertz's Shadowy Hands
-----------------------------------
-- Log ID: 3, Quest ID: 51
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_SHADOWY_HANDS,
    handAFId          = xi.item.CHAOS_GAUNTLETS,
    requiredLogId     = xi.questLog.BASTOK,
    requiredQuestId   = xi.quest.id.bastok.DARK_PUPPET,
    requiredJobId     = xi.job.DRK,
    oldGauntletZoneId = xi.zone.THE_ELDIEME_NECROPOLIS,
    optionalZoneId1   = xi.zone.CASTLE_OZTROJA,
    optionalZoneId2   = xi.zone.MONASTIC_CAVERN,
    optionalArtifact1 = xi.item.CHAOS_CUIRASS,
    optionalArtifact2 = xi.item.CHAOS_FLANCHARD,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
