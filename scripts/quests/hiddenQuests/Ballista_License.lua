-----------------------------------
-- Ballista License
--
-- Earns the licence the Herald and the Pursuivants ask for before letting anyone enter a match.
-- Rank 3 is required. The director of your own nation sends you to the other two nations' leaders
-- with a letter each; once both are delivered, and your own leader has seen you, the director
-- issues the licence. Afterwards the same director hands out, and takes back, the Ballista Earring.
--
-- San d'Oria:
--   Excenmille:        !pos -231 8 23 231
--   Great Hall door:   !pos 0 -1.5 13 233
--
-- Bastok:
--   Invincible_Shield: !pos -48 -10 2 237
--   President's door:  !pos 90 -20 0 237
--
-- Windurst:
--   Mhabi_Molkot:      !pos -4 0.25 26 242
--   Kupipi:            !pos 2 0 30 242
-----------------------------------

local quest = HiddenQuest:new('BallistaLicense')

quest.reward =
{
    keyItem = xi.keyItem.BALLISTA_LICENSE,
}

-- The letters a player carries are named for the commander they are addressed to, so each nation
-- hands out the two belonging to the other two nations.
local director =
{
    [xi.nation.SANDORIA] =
    {
        zone = xi.zone.NORTHERN_SAN_DORIA,
        name = 'Excenmille',

        lowRank        = 29,
        signUp         = 36,
        signUpAgain    = 31,
        deliverLetters = 34,
        afterLetters   = 33,
        licensed       = 32,
        otherNation    = 35,
        beforeLeader   = 30,

        acceptLetter =
        {
            [xi.nation.SANDORIA] = 27,
            [xi.nation.BASTOK]   = 26,
            [xi.nation.WINDURST] = 28,
        },

        letters =
        {
            [xi.nation.BASTOK]   = xi.keyItem.LETTER_TO_THE_BAS_CONFLICT_CMD1,
            [xi.nation.WINDURST] = xi.keyItem.LETTER_TO_THE_WIN_CONFLICT_CMD1,
        },
    },

    [xi.nation.BASTOK] =
    {
        zone = xi.zone.METALWORKS,
        name = 'Invincible_Shield',

        lowRank        = 810,
        signUp         = 813,
        signUpAgain    = 814,
        deliverLetters = 815,
        afterLetters   = 819,
        licensed       = 820,
        otherNation    = 824,
        beforeLeader   = 825,

        acceptLetter =
        {
            [xi.nation.SANDORIA] = 821,
            [xi.nation.BASTOK]   = 822,
            [xi.nation.WINDURST] = 823,
        },

        letters =
        {
            [xi.nation.SANDORIA] = xi.keyItem.LETTER_TO_THE_SAN_CONFLICT_CMD1,
            [xi.nation.WINDURST] = xi.keyItem.LETTER_TO_THE_WIN_CONFLICT_CMD2,
        },
    },

    [xi.nation.WINDURST] =
    {
        zone = xi.zone.HEAVENS_TOWER,
        name = 'Mhabi_Molkot',

        lowRank        = 410,
        signUp         = 413,
        signUpAgain    = 414,
        deliverLetters = 415,
        afterLetters   = 419,
        licensed       = 420,
        otherNation    = 424,
        beforeLeader   = 425,

        acceptLetter =
        {
            [xi.nation.SANDORIA] = 421,
            [xi.nation.BASTOK]   = 422,
            [xi.nation.WINDURST] = 423,
        },

        letters =
        {
            [xi.nation.SANDORIA] = xi.keyItem.LETTER_TO_THE_SAN_CONFLICT_CMD2,
            [xi.nation.BASTOK]   = xi.keyItem.LETTER_TO_THE_BAS_CONFLICT_CMD2,
        },
    },
}

local leader =
{
    [xi.nation.SANDORIA] =
    {
        zone = xi.zone.CHATEAU_DORAGUILLE,
        name = '_6h4', -- The Great Hall door

        -- One cutscene per nation. A capture of a Bastokan run has this door open event 71, and a
        -- Windurstian run opens 72. The local event dump lists only 70 and 72 for this actor, so it
        -- is incomplete here rather than 71 being unused.
        events =
        {
            [xi.nation.SANDORIA] = 70,
            [xi.nation.BASTOK]   = 71,
            [xi.nation.WINDURST] = 72,
        },
    },

    [xi.nation.BASTOK] =
    {
        zone = xi.zone.METALWORKS,
        name = '_6ld', -- The President's office door

        events =
        {
            [xi.nation.SANDORIA] = 828,
            [xi.nation.BASTOK]   = 827,
            [xi.nation.WINDURST] = 829,
        },
    },

    [xi.nation.WINDURST] =
    {
        zone = xi.zone.HEAVENS_TOWER,
        name = 'Kupipi',

        events =
        {
            [xi.nation.SANDORIA] = 427,
            [xi.nation.BASTOK]   = 428,
            [xi.nation.WINDURST] = 426,
        },
    },
}

-- Progress through the player's own nation:
--   0 has not spoken to the director
--   1 spoke to the director but declined
--   2 carrying the letters
--   3 delivered the letters and reported back
--   4 seen by their own leader, so the licence can be issued
local function getProgress(player)
    return quest:getVar(player, string.format('Prog%d', player:getNation()))
end

local function setProgress(player, value)
    quest:setVar(player, string.format('Prog%d', player:getNation()), value)
end

-- Whether a foreign leader has received the player yet, tracked per nation visited.
local function wasReceivedBy(player, npcNation)
    return quest:getVar(player, string.format('Prog%d%d', player:getNation(), npcNation)) == 1
end

local function setReceivedBy(player, npcNation)
    quest:setVar(player, string.format('Prog%d%d', player:getNation(), npcNation), 1)
end

local function lettersFor(nation)
    local carried = {}

    for _, letter in pairs(director[nation].letters) do
        table.insert(carried, letter)
    end

    return carried
end

local function carriesAnyLetter(player)
    for _, letter in pairs(director[player:getNation()].letters) do
        if player:hasKeyItem(letter) then
            return true
        end
    end

    return false
end

local function letterAddressedTo(player, npcNation)
    return director[player:getNation()].letters[npcNation]
end

local function hasLetterFor(player, npcNation)
    local letter = letterAddressedTo(player, npcNation)

    return letter ~= nil and player:hasKeyItem(letter)
end

-----------------------------------
-- The director of a nation, before the licence is earned.
-----------------------------------
local function directorTrigger(player, npcNation)
    local data = director[npcNation]

    if player:getNation() ~= npcNation then
        -- A foreign visitor only has business here if they are carrying our letter.
        if not hasLetterFor(player, npcNation) then
            return quest:event(data.otherNation, player:getNation())
        end

        if not wasReceivedBy(player, npcNation) then
            return quest:progressEvent(data.beforeLeader)
        end

        return quest:progressEvent(data.acceptLetter[player:getNation()])
    end

    if player:getRank(player:getNation()) < 3 then
        return quest:event(data.lowRank)
    end

    if carriesAnyLetter(player) then
        return quest:event(data.deliverLetters)
    end

    local progress = getProgress(player)

    if progress == 0 then
        return quest:progressEvent(data.signUp)
    elseif progress == 1 then
        return quest:progressEvent(data.signUpAgain)
    elseif progress <= 3 then
        return quest:progressEvent(data.afterLetters)
    end

    return quest:progressEvent(data.licensed)
end

local function onSignUp(player, csid, option)
    if option == 0 then
        -- Heard the offer but walked away.
        setProgress(player, 1)
        return
    end

    if
        option == 1 and
        npcUtil.giveKeyItem(player, lettersFor(player:getNation()))
    then
        setProgress(player, 2)
    end
end

local function directorSection(npcNation, licensed)
    local data    = director[npcNation]
    local npcs    = {}
    local finish  = {}

    if licensed then
        npcs[data.name] = function(player)
            if player:getNation() ~= npcNation then
                return quest:event(data.otherNation, player:getNation(), 1)
            end

            -- Option 1 offers the earring, option 2 takes it back.
            return quest:progressEvent(data.licensed, player:hasKeyItem(xi.keyItem.BALLISTA_EARRING) and 3 or 1)
        end

        finish[data.licensed] = function(player, csid, option)
            if option == 1 then
                npcUtil.giveKeyItem(player, xi.keyItem.BALLISTA_EARRING)
            elseif option == 2 then
                player:delKeyItem(xi.keyItem.BALLISTA_EARRING)
                player:messageSpecial(zones[data.zone].text.KEYITEM_RETURNED, xi.keyItem.BALLISTA_EARRING)
            end
        end
    else
        npcs[data.name] = function(player)
            return directorTrigger(player, npcNation)
        end

        finish[data.signUp]      = onSignUp
        finish[data.signUpAgain] = onSignUp

        finish[data.afterLetters] = function(player)
            setProgress(player, 3)
        end

        finish[data.licensed] = function(player, csid, option)
            if option == 3 then
                quest:complete(player)
            end
        end

        -- Taking a foreign visitor's letter, whichever nation they came from.
        for _, csid in pairs(data.acceptLetter) do
            finish[csid] = function(player)
                local letter = letterAddressedTo(player, npcNation)
                if letter == nil then
                    return
                end

                player:delKeyItem(letter)
                player:messageSpecial(zones[data.zone].text.KEYITEM_HAND_OVER, letter)
            end
        end
    end

    npcs.onEventFinish = finish

    return npcs
end

-----------------------------------
-- The leader of a nation, who receives the letter carrier.
-----------------------------------
local function leaderSection(npcNation)
    local data   = leader[npcNation]
    local finish = {}

    for nation, csid in pairs(data.events) do
        if nation == npcNation then
            finish[csid] = function(player)
                setProgress(player, 4)
            end
        else
            finish[csid] = function(player)
                setReceivedBy(player, npcNation)
            end
        end
    end

    return {
        [data.name] = function(player)
            if player:getNation() == npcNation then
                -- Own leader, and only once the director has sent them.
                if getProgress(player) == 3 then
                    return quest:progressEvent(data.events[player:getNation()])
                end

                return nil
            end

            if
                hasLetterFor(player, npcNation) and
                not wasReceivedBy(player, npcNation)
            then
                return quest:progressEvent(data.events[player:getNation()])
            end

            return nil
        end,

        onEventFinish = finish,
    }
end

-----------------------------------
-- Sections are grouped by the stage of the quest rather than by nation, so the gate that decides
-- which one applies is written once instead of three times.
-----------------------------------
quest.sections =
{
    -- Signing up, collecting letters, and being issued the licence.
    {
        check = function(player)
            return not player:hasKeyItem(xi.keyItem.BALLISTA_LICENSE)
        end,

        [director[xi.nation.SANDORIA].zone] = directorSection(xi.nation.SANDORIA, false),
        [director[xi.nation.BASTOK].zone]   = directorSection(xi.nation.BASTOK, false),
        [director[xi.nation.WINDURST].zone] = directorSection(xi.nation.WINDURST, false),
    },

    -- Being received by each nation's leader.
    {
        check = function(player)
            return not player:hasKeyItem(xi.keyItem.BALLISTA_LICENSE)
        end,

        [leader[xi.nation.SANDORIA].zone] = leaderSection(xi.nation.SANDORIA),
        [leader[xi.nation.BASTOK].zone]   = leaderSection(xi.nation.BASTOK),
        [leader[xi.nation.WINDURST].zone] = leaderSection(xi.nation.WINDURST),
    },

    -- The earring, once the licence is held.
    {
        check = function(player)
            return player:hasKeyItem(xi.keyItem.BALLISTA_LICENSE)
        end,

        [director[xi.nation.SANDORIA].zone] = directorSection(xi.nation.SANDORIA, true),
        [director[xi.nation.BASTOK].zone]   = directorSection(xi.nation.BASTOK, true),
        [director[xi.nation.WINDURST].zone] = directorSection(xi.nation.WINDURST, true),
    },
}

return quest
