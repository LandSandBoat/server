-----------------------------------
-- Area: Cloister of Storms
-- BCNM: Waking the Beast
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_STORMS,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_STORMS,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'LP_Entrance',
    exitNpc          = 'Lightning_Protocrystal',

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

-- can help if you are doing the quest or already completed the quest
function content:entryRequirement(player, npc, isRegistrant, trade)
    local hasQuestItem = player:hasKeyItem(xi.ki.RAINBOW_RESONATOR)
    local prevCompletedQuest = player:getQuestStatus(self.questArea, self.quest) == xi.questStatus.QUEST_COMPLETED

    -- registrant must actually be doing the quest
    if isRegistrant then
        return hasQuestItem
    -- others can help if they are either doing the quest or already completed the quest
    else
        return hasQuestItem or prevCompletedQuest
    end
end

content.groups =
{
    {
        mobs = { 'Ramuh_Prime_WTB' },
        allDeath = function(battlefield, mob)
            -- when avatar defeated then all elementals should also die
            for i = 1, 4 do
                local elemental = GetMobByID(mob:getID() + i)
                if elemental and elemental:isAlive() then
                    elemental:setHP(0)
                end
            end

            -- giving the player the eye key item is done in the WTB quest script
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobs =
        {
            'Ramuh_Prime_WTB',
            'Thunder_Elemental',
        },
        isParty   = true,
        superlink = true,
    },
}

return content:register()
