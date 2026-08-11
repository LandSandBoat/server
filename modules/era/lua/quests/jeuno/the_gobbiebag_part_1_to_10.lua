-----------------------------------
-- Increases the fame requirements for the Gobbiebag quests in Jeuno back to 75 era.
-- Requirements were lowered on Feb. 18th, 2014 : https://wiki.ffo.jp/html/30645.html
-----------------------------------
require('modules/module_utils')
require('scripts/quests/jeuno/helpers')
-----------------------------------
local m = Module:new('era_gobbiebag_fame_requirements', xi.pre(xi.expansion.SOA))

local eraFameRequirements =
{
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I   ] = 3,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II  ] = 4,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III ] = 5,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV  ] = 5,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V   ] = 6,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI  ] = 6,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII ] = 7,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII] = 7,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX  ] = 8,
    [xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X   ] = 9,
}

m:addOverride('xi.jeuno.helpers.GobbiebagQuest.new', function(self, params)
    params.fame = eraFameRequirements[params.questId] or params.fame

    return super(self, params)
end)
