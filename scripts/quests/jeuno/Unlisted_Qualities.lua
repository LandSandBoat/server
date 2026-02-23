-----------------------------------
-- Unlisted Qualities
-----------------------------------
-- Log ID: 3, Quest ID: 77
-- Luto Mewrilah: !pos -52 0 46 244
-- Red Ghost:     !pos -99 0 0 246
-- Akta:          !pos 6 0 -68.6 243
-- Kuah Dakonsa:  !pos -40 0 -65 245
-- Bheem:         !pos -89 0 168 244
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)

-- Packs Fellow properties into a single integer, as expected by events.
-- 0000 0000 FFFF SS00 00PP PP00 0RRR NNNN
-- Face, Size, Personality, Race, Name
local function packData(name, race, pers, face, size)
    return bit.bor(
        name,
        bit.lshift(race, 4),
        bit.lshift(pers >= 1 and pers or 0, 10),
        bit.lshift(size >= 1 and size or 0, 18),
        bit.lshift(face >= 0 and face or 15, 20)
    )
end

local function unpackData(packed)
    local rawPers = bit.band(bit.rshift(packed, 10), 0x0F)
    local rawSize = bit.band(bit.rshift(packed, 18), 0x03)
    local rawFace = bit.band(bit.rshift(packed, 20), 0x0F)

    return
    {
        name = bit.band(packed, 0x0F),
        race = bit.band(bit.rshift(packed, 4), 0x07),
        pers = rawPers >= 1 and rawPers or -1,
        size = rawSize >= 1 and rawSize or -1,
        face = rawFace < 15 and rawFace or -1,
    }
end

-- Check if all 3 NPC info gathered, advance to Bheem phase
local function checkAdvanceToPhase1(player)
    local d = unpackData(quest:getVar(player, 'Data'))
    if d.pers >= 1 and d.face >= 0 and d.size >= 1 then
        quest:setVar(player, 'Prog', 1)
    end
end

quest.sections =
{
    -- Quest start: Talk to Luto, select name/race
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Luto_Mewrilah'] = quest:event(10031):importantOnce(),

            onEventFinish =
            {
                [10031] = function(player, csid, option, npc)
                    if option == utils.EVENT_CANCELLED_OPTION then
                        return
                    end

                    -- Parse race and name from option (0-indexed)
                    local name = bit.band(option, 0x0F)
                    local race = bit.band(bit.rshift(option, 4), 0x07)

                    -- 8 races, 8 names per race.
                    if race > 7 or name > 7 then
                        return
                    end

                    quest:begin(player)
                    quest:setVar(player, 'Data', packData(name, race, -1, -1, -1))
                end,
            },
        },
    },

    -- Prog 0: Gather info from NPCs (size, face, personality)
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Luto_Mewrilah'] = quest:event(10033),
            ['Bheem']         = quest:event(10037):oncePerZone(),
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Akta'] =
            {
                onTrigger = function(player, npc)
                    local data = quest:getVar(player, 'Data')
                    local d    = unpackData(data)

                    if d.size == -1 then
                        return quest:event(10103, { [7] = data })
                    end
                end,
            },

            onEventFinish =
            {
                [10103] = function(player, csid, option, npc)
                    -- 1 = Small, 2 = Average Height, 3 = Pretty Tall
                    if option < 1 or option > 3 then
                        return
                    end

                    local d = unpackData(quest:getVar(player, 'Data'))
                    quest:setVar(player, 'Data', packData(d.name, d.race, d.pers, d.face, option))
                    checkAdvanceToPhase1(player)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Kuah_Dakonsa'] =
            {
                onTrigger = function(player, npc)
                    local data = quest:getVar(player, 'Data')
                    local d    = unpackData(data)

                    if d.face == -1 then
                        return quest:event(20000, { [7] = data })
                    end
                end,
            },

            onEventFinish =
            {
                [20000] = function(player, csid, option, npc)
                    -- Event returns 0-15 for faces 1A-8B
                    if option < 0 or option > 15 then
                        return
                    end

                    local d = unpackData(quest:getVar(player, 'Data'))
                    quest:setVar(player, 'Data', packData(d.name, d.race, d.pers, option, d.size))
                    checkAdvanceToPhase1(player)
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Red_Ghost'] =
            {
                onTrigger = function(player, npc)
                    local data = quest:getVar(player, 'Data')
                    local d    = unpackData(data)

                    if d.pers == -1 then
                        return quest:event(320, { [7] = data })
                    end
                end,
            },

            onEventFinish =
            {
                [320] = function(player, csid, option, npc)
                    if option < 0 and option > 11 then
                        return
                    end

                    local d           = unpackData(quest:getVar(player, 'Data'))
                    -- Race is 0-indexed here (unlike xi.race enum)
                    local isFemale    = (d.race % 2 == 1 and d.race ~= 7) or d.race == 6

                    -- Red Ghost returns 0-5 for male, 6-11 for female
                    local validMale   = option >= 0 and option <= 5
                    local validFemale = option >= 6 and option <= 11

                    if (isFemale and validFemale) or (not isFemale and validMale) then
                        -- This gets stored as +1 as Bheem expects it 1-indexed.
                        quest:setVar(player, 'Data', packData(d.name, d.race, option + 1, d.face, d.size))
                        checkAdvanceToPhase1(player)
                    end
                end,
            },
        },
    },

    -- Prog 1: Talk to Bheem after gathering all info
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Bheem'] =
            {
                onTrigger = function(player, npc)
                    local data = quest:getVar(player, 'Data')
                    return quest:event(10171, { [7] = data })
                end,

                onEventUpdate = function(player, csid, option, npc)
                    local data = quest:getVar(player, 'Data')
                    player:updateEvent({ [7] = data })
                end,
            },

            onEventFinish =
            {
                [10171] = function(player, csid, option, npc)
                    if option == utils.EVENT_CANCELLED_OPTION then
                        return
                    end

                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Prog 2: Return to Luto Mewrilah to complete
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Luto_Mewrilah'] = quest:progressEvent(10032),

            -- TODO: Quest completion disabled until core changes made to save Fellows
            -- onEventFinish =
            -- {
            --     [10032] = function(player, csid, option, npc)
            --         if option == 0 and npcUtil.giveItem(player, xi.item.SILVER_INGOT) then
            --             quest:complete(player)
            --         end
            --     end,
            -- },
        },
    },
}

return quest
