-----------------------------------
-- Area: LaLoff Amphitheater
-- Name: Divine Might
-----------------------------------
local laLoffID = zones[xi.zone.LALOFF_AMPHITHEATER]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.LALOFF_AMPHITHEATER,
    battlefieldId = xi.battlefield.id.DIVINE_MIGHT,
    canLoseExp    = false,
    allowTrusts   = true,
    maxPlayers    = 18,
    levelCap      = 99,
    timeLimit     = utils.minutes(30),
    index         = 5,
    entryNpcs     = { 'qm1_1', 'qm1_2', 'qm1_3', 'qm1_4', 'qm1_5' },

    -- TODO: wornMessage needs verification, but is necessary to ensure item cannot be reused.
    requiredItems = { xi.item.ARK_PENTASPHERE, wearMessage = laLoffID.text.THE_SEAL_FADES, wornMessage = { laLoffID.text.LARGE_CRACK_RUNNING_DOWN, xi.item.ARK_PENTASPHERE } },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT) == xi.questStatus.QUEST_ACCEPTED or
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT) == xi.questStatus.QUEST_ACCEPTED
end

content.groups =
{
    {
        mobIds =
        {
            {
                laLoffID.mob.ARK_ANGEL_HM + 24,
                laLoffID.mob.ARK_ANGEL_MR + 22,
                laLoffID.mob.ARK_ANGEL_EV + 16,
                laLoffID.mob.ARK_ANGEL_TT + 14,
                laLoffID.mob.ARK_ANGEL_GK + 12,
            },

            {
                laLoffID.mob.ARK_ANGEL_HM + 32,
                laLoffID.mob.ARK_ANGEL_MR + 30,
                laLoffID.mob.ARK_ANGEL_EV + 24,
                laLoffID.mob.ARK_ANGEL_TT + 22,
                laLoffID.mob.ARK_ANGEL_GK + 20,
            },

            {
                laLoffID.mob.ARK_ANGEL_HM + 40,
                laLoffID.mob.ARK_ANGEL_MR + 38,
                laLoffID.mob.ARK_ANGEL_EV + 32,
                laLoffID.mob.ARK_ANGEL_TT + 30,
                laLoffID.mob.ARK_ANGEL_GK + 28,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    -- AAMR: Tiger
    {
        mobIds =
        {
            { laLoffID.mob.ARK_ANGEL_MR + 23 },
            { laLoffID.mob.ARK_ANGEL_MR + 31 },
            { laLoffID.mob.ARK_ANGEL_MR + 39 },
        },

        spawned = false,
    },

    -- AAMR: Mandragora
    {
        mobIds =
        {
            { laLoffID.mob.ARK_ANGEL_MR + 24 },
            { laLoffID.mob.ARK_ANGEL_MR + 32 },
            { laLoffID.mob.ARK_ANGEL_MR + 40 },
        },

        spawned = false,
    },

    -- AAGK: Wyvern
    {
        mobIds =
        {
            { laLoffID.mob.ARK_ANGEL_GK + 13 },
            { laLoffID.mob.ARK_ANGEL_GK + 21 },
            { laLoffID.mob.ARK_ANGEL_GK + 29 },
        },

        spawned = false,
    },
}

return content:register()
