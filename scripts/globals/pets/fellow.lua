-----------------------------------
--  Adventuring Fellow
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/zone")
require("scripts/globals/fellow_utils")
-----------------------------------
local entity = {}

local fellowTypes =
{
    NONE     = 0,
    SHIELD   = 1,
    ATTACKER = 2,
    HEALER   = 3,
    STALWART = 4,
    FIERCE   = 5,
    SOOTHING = 6,
}

local fellowChatGeneral = 1

local fellowMessageOffsets =
{
    WS_READY         =   0,
    HP_LOW_NOTICE    =  15,
    MP_LOW_NOTICE    =  30,
    TIME_EXPIRED     =  75,
    LEAVE            =  90,
    PROVOKE          = 135,
    FIVE_MIN_WARNING = 165,
    WEAPONSKILL      = 211,
    WEAPONSKILL2     = 463,
}

local function checkProvoke(mob, target, fellowType)
    local master = mob:getMaster()
    if master == nil then
        return false
    end

    if
        fellowType == fellowTypes.SHIELD or
        fellowType == fellowTypes.STALWART or
        master:getHPP() < 25
    then
        if
            mob:actionQueueEmpty() and
            (mob:getHPP() > 25 or
            master:getHPP() < 10)
        then
            if target:isEngaged() then
                if target:getTarget():getID() ~= mob:getID() then
                    mob:useJobAbility(35, target)
                    mob:setLocalVar("provoke", os.time() + math.random(30, 60))
                    return true
                end
            else -- edge case for independent fellow attacking (quest bcnms)
                mob:useJobAbility(35, target)
                mob:setLocalVar("provoke", os.time() + math.random(30, 60))
                return true
            end
        end
    end

    return false
end

local function checkWeaponSkill(mob, target, fellowLvl)
    local weaponskills =
        {
            [xi.skill.HAND_TO_HAND] =
                {
                    [1] = { 1, false }, -- combo
                    [2] = { 13, false }, -- shoulder tackle
                    [3] = { 24, false }, -- one inch punch
                    [4] = { 33, false }, -- backhand blow
                    [5] = { 41, false }, -- raging fists
                    [6] = { 49, true }, -- spinning attack
                    [7] = { 60, false }, -- howling fist
                    [8] = { 65, false }, -- dragon kick
                },
            [xi.skill.DAGGER] =
                {
                    [16] = { 1, false }, -- wasp sting
                    [17] = { 13, false }, -- gust slash
                    [18] = { 23, false }, -- shadowstitch
                    [19] = { 33, false }, -- viper bite
                    [20] = { 41, true }, -- cyclone
                    [21] = { 49, false }, -- energy steal
                    [22] = { 55, false }, -- energy drain
                    [23] = { 60, false }, -- dancing edge
                    [24] = { 66, false }, -- shark bite
                },
            [xi.skill.SWORD] =
                {
                    [32] = { 1, false }, -- fast blade
                    [33] = { 9, false }, -- burning blade
                    [34] = { 16, false }, -- red lotus blade
                    [35] = { 24, false }, -- flat blade
                    [36] = { 33, false }, -- shining blade
                    [37] = { 41, false }, -- seraph blade
                    [38] = { 49, true }, -- circle blade
                    [39] = { 55, false }, -- spirits within
                    [40] = { 60, false }, -- vorpal blade
                    [41] = { 65, false }, -- swift blade
                },
            [xi.skill.GREAT_SWORD] =
                {
                    [48] = { 1, false }, -- hard slash
                    [49] = { 9, false }, -- power slash
                    [50] = { 23, false }, -- frostbite
                    [51] = { 33, false }, -- freezebite
                    [52] = { 49, true }, -- shockwave
                    [53] = { 55, false }, -- crescent moon
                    [54] = { 60, false }, -- sickle moon
                    [55] = { 65, false }, -- spinning slash
                },
            [xi.skill.AXE] =
                {
                    [64] = { 1, false }, -- raging axe
                    [65] = { 13, false }, -- smash axe
                    [66] = { 23, false }, -- gale axe
                    [67] = { 33, false }, -- avalanche axe
                    [68] = { 49, false }, -- spinning axe
                    [69] = { 55, false }, -- rampage
                    [70] = { 60, false }, -- calamity
                    [71] = { 66, false }, -- mistral axe
                },
            [xi.skill.GREAT_AXE] =
                {
                    [80] = { 1, false }, -- shield break
                    [81] = { 13, false }, -- iron tempest
                    [82] = { 23, false }, -- sturmwind
                    [83] = { 33, false }, -- armor break
                    [84] = { 49, false }, -- keen edge
                    [85] = { 55, false }, -- weapon break
                    [86] = { 60, false }, -- raging rush
                    [87] = { 65, false }, -- full break
                },
            [xi.skill.SCYTHE] =
                {
                    [96] = { 1, false }, -- slice
                    [97] = { 9, false }, -- dark harvest
                    [98] = { 23, false }, -- shadow of death
                    [99] = { 33, false }, -- nightmare scythe
                    [100] = { 41, true }, -- spinning scythe
                    [101] = { 49, false }, -- vorpal scythe
                    [102] = { 60, false }, -- guillotine
                    [103] = { 65, false }, -- cross reaper
                },
            [xi.skill.POLEARM] =
                {
                    [112] = { 1, false }, -- double thrust
                    [113] = { 9, false }, -- thunder thrust
                    [114] = { 23, false }, -- raiden thrust
                    [115] = { 33, false }, -- leg sweep
                    [116] = { 49, false }, -- penta thrust
                    [117] = { 55, false }, -- vorpal thrust
                    [118] = { 60, false }, -- skewer
                    [119] = { 65, false }, -- wheeling thrust
                },
            [xi.skill.KATANA] =
                {
                    [128] = { 1, false }, -- blade: rin
                    [129] = { 9, false }, -- blade: retsu
                    [130] = { 23, false }, -- blade: teki
                    [131] = { 33, false }, -- blade: to
                    [132] = { 49, false }, -- blade: chi
                    [133] = { 55, false }, -- blade: ei
                    [134] = { 60, false }, -- blade: jin
                    [135] = { 66, false }, -- blade: ten
                },
            [xi.skill.GREAT_KATANA] =
                {
                    [144] = { 1, false }, -- tachi: enpi
                    [145] = { 9, false }, -- tachi: hobaku
                    [146] = { 23, false }, -- tachi: goten
                    [147] = { 33, false }, -- tachi: kagero
                    [148] = { 49, false }, -- tachi: jinpu
                    [149] = { 55, false }, -- tachi: koki
                    [150] = { 60, false }, -- tachi: yukikaze
                    [151] = { 65, false }, -- tachi: gekko
                },
            [xi.skill.CLUB] =
                {
                    [160] = { 1, false }, -- shining strike
                    [161] = { 13, false }, -- seraph strike
                    [162] = { 23, false }, -- brainshaker
                    [163] = { 33, false }, -- starlight
                    [164] = { 41, false }, -- moonlight
                    [165] = { 49, false }, -- skullbreaker
                    [166] = { 55, false }, -- true strike
                    [167] = { 60, false }, -- judgment
                    [168] = { 67, false }, -- hexa strike
                },
            [xi.skill.STAFF] =
                {
                    [176] = { 1, false }, -- heavy swing
                    [177] = { 13, false }, -- rock crusher
                    [178] = { 23,  true }, -- earth crusher
                    [179] = { 33, false }, -- starburst
                    [180] = { 49, false }, -- sunburst
                    [181] = { 55, false }, -- shell crusher
                    [182] = { 60, false }, -- full swing
                    [183] = { 63, false }, -- spirit taker
                },
        }

    local master = mob:getMaster()
    if master == nil then
        return false
    end

    local skill         = mob:getWeaponSkillType(xi.slot.MAIN)
    local optionsMask   = master:getFellowValue("optionsMask")
    local randomWS      = {}
    local aoeEnabled    = false
    if bit.band(optionsMask, bit.lshift(1, 0)) == 1 then
        aoeEnabled = true
    end

    for i, ws in pairs(weaponskills[skill]) do
        if
            fellowLvl >= ws[1] and
            (aoeEnabled == ws[2] or
            not ws[2])
        then
            table.insert(randomWS, i)
        end
    end

    -- Building in a delay as on local this can be triggered fast enough that
    -- mob:actionQueueEmpty() is false for 2-3 calls in a row, letting the fellow queue up to 3 ws
    -- Also accounting for disengage/re-engage
    local wsTime = mob:getLocalVar("wsTime")
    if
        mob:getBattleTime() > wsTime + 10 or
        wsTime > mob:getBattleTime() + 30
    then
        mob:setLocalVar("wsTime", 0)
    end

    if
        mob:actionQueueEmpty() and
        mob:getLocalVar("wsTime") == 0
    then
        mob:setLocalVar("wsTime", mob:getBattleTime())
        local ws = randomWS[math.random(#randomWS)]

        -- Starlight and Moonlight target the fellow
        if ws == 163 or ws == 164 then
            target = mob
        end

        mob:useMobAbility(ws, target)

        mob:setLocalVar("wsReady", 0)
        return true
    end

    return false
end

local accuracy =
{ -- hpp, fellowType, accuracy(chance to use full pwr), validity(does this type cast at this hpp)
    [1] = { hpp = 30, job = { [3] = { 95,  true }, [4] = { 100, true }, [6] = { 100, true } } },
    [2] = { hpp = 50, job = { [3] = { 70,  true }, [4] = { 100, true }, [6] = { 90, true } } },
    [3] = { hpp = 60, job = { [3] = { 50,  true }, [4] = { 100, true }, [6] = { 80, true } } },
    [4] = { hpp = 70, job = { [3] = { 0, false }, [4] = {  0, true }, [6] = { 10, true } } },
    [5] = { hpp = 80, job = { [3] = { 0, false }, [4] = {  0, true }, [6] = {  0, true } } },
}

local function doFellowCure (mob, fellowType, cureSpell)
    for i, v in ipairs(accuracy) do
        if
            mob:getHPP() <= v.hpp and
            v.job[fellowType][2]
        then
            if
                cureSpell > 1 and
                math.random(100) > v.job[fellowType][1]
            then
                mob:castSpell(cureSpell -1, mob)
                return true
            else
                mob:castSpell(cureSpell, mob)
                return true
            end
        end
    end
end

local function doMasterCure(mob, master, fellowType, cureSpell)
    for i, v in ipairs(accuracy) do
        if
            master:getHPP() <= v.hpp and
            v.job[fellowType][2]
        then
            if
                cureSpell > 1 and
                math.random(100) > v.job[fellowType][1]
            then
                mob:castSpell(cureSpell -1, master)
                return true
            else
                mob:castSpell(cureSpell, master)
                return true
            end
        end
    end
end

local function checkCure(mob, master, fellowLvl, mp, fellowType)
    if master == nil then
        return false
    end

    local cureSpell = 0
    local cures =
    { -- spellid, lvl, mpcost
        [1] = { 5, 61, 135 }, -- cure V
        [2] = { 4, 41,  88 }, -- cure IV
        [3] = { 3, 21,  46 }, -- cure III
        [4] = { 2, 11,  24 }, -- cure II
        [5] = { 1,  1,   8 }, -- cure I
    }

    for i, cure in ipairs(cures) do
        if
            fellowLvl >= cure[2] and
            mp >= cure[3]
        then
            cureSpell = cure[1]
            break
        end
    end

    if cureSpell > 0 then
        if fellowType == 3 then
            if
                doFellowCure(mob, fellowType, cureSpell) or
                doMasterCure(mob, master, fellowType, cureSpell)
            then
                return true
            end
        elseif fellowType == 4 then
            if doFellowCure(mob, fellowType, cureSpell) then
                return true
            end
        elseif fellowType == 6 then
            if
                doMasterCure(mob, master, cureSpell) or
                doFellowCure(mob, fellowType, fellowType, cureSpell)
            then
                return true
            end
        end
    end

    return false
end

local function checkBuff(mob, master, fellowLvl, mp, fellowType)
    if master == nil then
        return false
    end

    local mpp = mob:getMP() / mob:getMaxMP() * 100
    local pS = {}
    local sS = {}
    local protects =
    { -- spellid, lvl, mpcost
        [1] = { 46, 63, 65 }, -- protect IV
        [2] = { 45, 47, 46 }, -- protect III
        [3] = { 44, 27, 28 }, -- protect II
        [4] = { 43,  7,  9 }, -- protect I
    }
    for i, protect in ipairs(protects) do
        if fellowLvl >= protect[2] then
            pS = protects[i]
            break
        end
    end

    local shells =
    { -- spellid, lvl, mpcost
        [1] = { 51, 68, 75 }, -- shell IV
        [2] = { 50, 57, 56 }, -- shell III
        [3] = { 49, 37, 37 }, -- shell II
        [4] = { 48, 17, 18 }, -- shell I
    }
    for i, shell in ipairs(shells) do
        if fellowLvl >= shell[2] then
            sS = shells[i]
            break
        end
    end

    local buffs =
    {                        -- spellid, lvl, mpcost, canTarget, job, priority, cutoff
        [xi.effect.STONESKIN] = { 54,    28,    29, false, job = { [3] = { 10, 0 }, [6] = { 20, 60 } } },
        [xi.effect.PROTECT]   = { pS[1], pS[2], pS[3],  true, job = { [3] = { 50, 0 }, [6] = { 50,  0 } } },
        [xi.effect.SHELL]     = { sS[1], sS[2], sS[3],  true, job = { [3] = { 50, 0 }, [6] = { 50,  0 } } },
        [xi.effect.BLINK]     = { 53,    19,    20, false, job = { [3] = { 10, 0 }, [6] = { 20, 60 } } },
        [xi.effect.HASTE]     = { 57,    40,    40,  true, job = { [3] = { 65, 0 }, [6] = { 65, 30 } } },
    }

    if master:getFellowValue("job") == fellowTypes.SOOTHING then
        switch (master:getMainJob()) : caseof
        {
            [xi.job.WHM] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.BLM] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.RDM] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.BRD] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.RNG] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.SMN] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.COR] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,

            [xi.job.SCH] = function(x)
                buffs[xi.effect.HASTE].job[6][2] = 80
            end,
        }
    end

    for status, spell in pairs(buffs) do
        if
            math.random(100) < spell.job[fellowType][1] and
            mpp > spell.job[fellowType][2]
        then
            if
                not mob:hasStatusEffect(status) and
                fellowLvl >= spell[2] and mp >= spell[3]
            then
                mob:castSpell(spell[1], mob)
                return true
            end
        elseif
            math.random(100) < spell.job[fellowType][1] and
            mpp > spell.job[fellowType][2] and spell[4]
        then
            if
                not master:hasStatusEffect(status) and
                fellowLvl >= spell[2] and
                mp >= spell[3]
            then
                mob:castSpell(spell[1], master)
                return true
            end
        end
    end

    return false
end

local function checkDebuff(mob, target, master, fellowLvl, mp)
    if master == nil then
        return false
    end

    local dS = {}
    local dias =
    { -- spellid, lvl, mpcost
        [1] = { 24, 36, 30 }, -- dia II
        [2] = { 23,  3,  7 }, -- dia I
    }
    for i, dia in ipairs(dias) do
        if fellowLvl >= dia[2] then
            dS = dias[i]
            break
        end
    end

    local debuffs =
    {                       -- spellid, lvl, mpcost, priority, immunity
        [xi.effect.PARALYSIS] = {   58,     4,     6, 25,  32 },
        [xi.effect.SILENCE]   = {   59,    15,    16, 60,  16 },
        [xi.effect.SLOW]      = {   56,    13,    15, 25, 128 },
        [xi.effect.DIA]       = { dS[1], dS[2], dS[3], 75,   0 },
    }

    if not target:hasSpellList() then
        debuffs[xi.effect.SILENCE] = nil
    end

    for status, spell in pairs(debuffs) do
        if
            math.random(100) < spell[4] and
            not target:hasImmunity(spell[5])
        then
            if
                not target:hasStatusEffect(status) and
                fellowLvl >= spell[2] and
                mp >= spell[3]
            then
                mob:castSpell(spell[1], target)
                return true
            end
        end
    end

    return false
end

local function checkAilment(mob, master, fellowLvl, mp)
    if master == nil then
        return false
    end

    local ailments =
    {                        -- spellid, lvl, mpcost, selfcast
        [xi.effect.PETRIFICATION] = { 18, 40, 12, false },
        [xi.effect.BLINDNESS]     = { 16, 14, 16,  true },
        [xi.effect.PARALYSIS]     = { 15,  9, 12,  true },
        [xi.effect.CURSE_II]      = { 20, 29, 30,  true },
        [xi.effect.CURSE_I]       = { 20, 29, 30,  true },
        [xi.effect.DISEASE]       = { 19, 34, 48,  true },
        [xi.effect.SILENCE]       = { 17, 19, 24, false },
        [xi.effect.POISON]        = { 14,  6,  8,  true },
    }

    for status, spell in pairs(ailments) do
        if
            mob:hasStatusEffect(status) and
            fellowLvl >= spell[2] and
            mp >= spell[3] and spell[4]
        then
            mob:castSpell(spell[1], mob)
            return true
        elseif
            master:hasStatusEffect(status) and
            fellowLvl >= spell[2] and
            mp >= spell[3]
        then
            mob:castSpell(spell[1], master)
            return true
        end
    end

    return false
end

entity.onMobSpawn = function(mob)
    local master        = mob:getMaster()
    mob:setLocalVar("masterID", master:getID())
    mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
    master:setLocalVar("chatCounter", 0)
    master:setFellowValue("spawnTime", os.time())

    if master:getLocalVar("FellowAttack") == 0 then
        master:addListener("ATTACK", "FELLOW_ENGAGE", function(player, target, action)
            local fellow = player:getFellow()
            if fellow ~= nil then
                if
                    fellow:getTarget() == nil or
                    target:getID() ~= fellow:getTarget():getID()
                then
                    player:fellowAttack(target)
                end
            end
        end)
    end

    if master:getLocalVar("FellowDisengage") == 0 then
        master:addListener("DISENGAGE", "FELLOW_DISENGAGE", function(player)
            local fellow = player:getFellow()
            if fellow ~= nil then
                player:fellowRetreat()
            end
        end)
    end
end

entity.onTrigger = function(player, mob)
    local ID            = require("scripts/zones/"..player:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(mob)
    if personality > 5 then
        personality = personality - 1
    end

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and
        player:getCharVar("[Quest]Looking_Glass") == 3
    then
        player:setLocalVar("triggerFellow", 0)
        player:setCharVar("[Quest]Looking_Glass", 4)
        player:showText(mob, ID.text.GIRL_BACK_TO_JEUNO + personality)
        player:timer(6000, function(playerArg)
            playerArg:despawnFellow()
        end)
    else
        player:triggerFellowChat(fellowChatGeneral)
    end
end

entity.onMobRoam = function(mob)
    local master        = mob:getMaster()
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(mob)
    local fellowType    = master:getFellowValue("job")
    local maxTime       = master:getFellowValue("maxTime")
    local spawnTime     = master:getFellowValue("spawnTime")
    local castCool      = mob:getLocalVar("castingCoolDown")
    local timeWarning   = mob:getLocalVar("timeWarning")
    local fellowLvl     = mob:getMainLvl()
    local mpNotice      = mob:getLocalVar("mpNotice")
    local mp            = mob:getMP()
    local mpp           = mp / mob:getMaxMP() * 100

    local members = 0
    local fellows = {}
    local party = master:getParty()
    if #party > 3 then
        for i, player in pairs(party) do
            if mob:getZone():getID() == player:getZone():getID() then
                if player:getFellow() ~= nil then
                    members = members + 2
                    fellows[player:getID()] = player:getFellowValue("spawnTime")
                else
                    members = members + 1
                end
            end
        end

        if members > 6 then
            local oldestTime = 0
            local oldestFellow = 0
            for i, fellow in pairs(fellows) do
                if
                    oldestTime == 0 or
                    fellow < oldestTime
                then
                    oldestTime = fellow
                    oldestFellow = i
                end
            end

            GetPlayerByID(oldestFellow):despawnFellow()
        end
    end

    if
        os.time() > spawnTime + maxTime - 300 and
        timeWarning == 0
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.FIVE_MIN_WARNING + personality)
        mob:setLocalVar("timeWarning", 1)
    elseif
        os.time() > spawnTime + maxTime - 4 and
        timeWarning == 1
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.TIME_EXPIRED + personality)
        mob:setLocalVar("timeWarning", 2)
    elseif
        os.time() > spawnTime + maxTime and
        timeWarning == 2
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.LEAVE + personality)
        mob:setLocalVar("timeWarning", 3)
        master:despawnFellow()
    end

    if castCool <= os.time() then
        if
            fellowType == fellowTypes.HEALER or
            fellowType == fellowTypes.SOOTHING
        then
            if
                math.random(10) < fellowType + 3 and
                checkCure(mob, master, fellowLvl, mp, fellowType)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            elseif
                math.random(10) < fellowType + 1 and
                checkAilment(mob, master, fellowLvl, mp)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            elseif
                math.random(10) < fellowType - 1 and
                checkBuff(mob, master, fellowLvl, mp, fellowType)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            end
        end
    end

    if
        mpp < 67 and
        mpNotice ~= 1
    then
        mob:setLocalVar("mpNotice", 1)
    end
end

-- TODO: Reduce complexity by refactoring most of this into helper fcns and fellow_utils
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
entity.onMobFight = function(mob, target)
    local master = mob:getMaster()
    if master == nil then
        return
    end

    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = xi.fellow_utils.checkPersonality(mob)
    local fellowType    = master:getFellowValue("job")
    local maxTime       = master:getFellowValue("maxTime")
    local optionsMask   = master:getFellowValue("optionsMask")
    local spawnTime     = master:getFellowValue("spawnTime")
    local castCool      = mob:getLocalVar("castingCoolDown")
    local provoke       = mob:getLocalVar("provoke")
    local hpWarning     = mob:getLocalVar("hpWarning")
    local mpWarning     = mob:getLocalVar("mpWarning")
    local timeWarning   = mob:getLocalVar("timeWarning")
    local wsReady       = mob:getLocalVar("wsReady")
    local wsTime        = mob:getLocalVar("wsTime")
    local fellowLvl     = mob:getMainLvl()
    local mpNotice      = mob:getLocalVar("mpNotice")
    local mp            = mob:getMP()
    local mpp           = mp / mob:getMaxMP() * 100
    local hpSignals     = false
    if bit.band(optionsMask, bit.lshift(1, 1)) == 2 then
        hpSignals = true
    end

    local mpSignals     = false
    if bit.band(optionsMask, bit.lshift(1, 2)) == 4 then
        mpSignals = true
    end

    local wsSignals     = false
    if bit.band(optionsMask, bit.lshift(1, 3)) == 8 then
        wsSignals = true
    end

    local otherSignals  = false
    if bit.band(optionsMask, bit.lshift(1, 4)) == 16 then
        otherSignals = true
    end

    if
        os.time() > spawnTime + maxTime - 300 and
        timeWarning == 0
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.FIVE_MIN_WARNING + personality)
        mob:setLocalVar("timeWarning", 1)
    elseif
        os.time() > spawnTime + maxTime - 4 and
        timeWarning == 1
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.TIME_EXPIRED + personality)
        mob:setLocalVar("timeWarning", 2)
    elseif
        os.time() > spawnTime + maxTime and
        timeWarning == 2
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.LEAVE + personality)
        mob:setLocalVar("timeWarning", 3)
        master:despawnFellow()
    end

    if provoke <= os.time() then
        if
            checkProvoke(mob, target, fellowType) and
            otherSignals
        then
            master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.PROVOKE + personality)
        end
    end

    if
        fellowType == fellowTypes.ATTACKER or
        fellowType == fellowTypes.FIERCE
    then
        if mob:getTP() == 3000 then
            if
                checkWeaponSkill(mob, target, fellowLvl) and
                otherSignals
            then
                master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
            end
        elseif mob:getTP() > 1000 then
            if
                wsSignals and
                wsReady == 0 and
                master:getTP() < 1000 and
                master:getTP() > 500
            then
                master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WS_READY + personality)
                mob:setLocalVar("wsReady", 1)
            elseif
                (fellowType == fellowTypes.ATTACKER and
                (master:getTP() > 1000 or
                master:getTP() < 500)) or
                (fellowType == fellowTypes.FIERCE and
                master:getTP() < 500)
            then
                    if
                        checkWeaponSkill(mob, target, fellowLvl) and
                        otherSignals
                    then
                        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                    end
            elseif
                fellowType == fellowTypes.FIERCE and
                master:getTP() > 1000 and
                wsReady == 0 and
                target:getHPP() > 15
            then
                master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL2 + personality)
                mob:setLocalVar("wsTime", os.time() + 5)
                mob:setLocalVar("wsReady", 1)
            elseif
                fellowType == fellowTypes.FIERCE and
                master:getTP() > 1000 and
                wsTime <= os.time()
            then
                if
                    checkWeaponSkill(mob, target, fellowLvl) and
                    otherSignals
                then
                    master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
                end
            end
        end
    elseif mob:getTP() > 1000 then
        if
            checkWeaponSkill(mob, target, fellowLvl) and
            otherSignals
        then
            master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.WEAPONSKILL + personality)
        end
    end

    if castCool <= os.time() then
        if
            fellowType == fellowTypes.HEALER or
            fellowType == fellowTypes.SOOTHING
        then
            if
                math.random(10) < fellowType + 4 and
                checkCure(mob, master, fellowLvl, mp, fellowType)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            elseif
                math.random(10) < fellowType + 2 and
                checkAilment(mob, master, fellowLvl, mp)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            elseif
                math.random(10) < fellowType and
                checkDebuff(mob, target, master, fellowLvl, mp)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            elseif
                math.random(10) < fellowType - 1 and
                checkBuff(mob, master, fellowLvl, mp, fellowType)
            then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            end
        elseif fellowType == fellowTypes.STALWART then
            if checkCure(mob, master, fellowLvl, mp, fellowType) then
                mob:setLocalVar("castingCoolDown", os.time() + math.random(15, 25))
            end
        end
    end

    if
        mob:getHPP() <= 25 and
        hpWarning == 0 and
        hpSignals
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.HP_LOW_NOTICE + personality)
        mob:setLocalVar("hpWarning", 1)
    elseif
        mob:getHPP() > 25 and
        hpWarning ~= 0
    then
        mob:setLocalVar("hpWarning", 0)
    elseif
        mpp <= 25 and
        mpWarning == 0 and
        mpSignals
    then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + fellowMessageOffsets.MP_LOW_NOTICE + personality)
        mob:setLocalVar("mpWarning", 1)
    elseif
        mpp > 25 and
        mpWarning ~= 0
    then
        mob:setLocalVar("mpWarning", 0)
    end

    if
        mpp < 67 and
        mpNotice ~= 1
    then
        mob:setLocalVar("mpNotice", 1)
    end
end

entity.onMobDeath = function(mob)
    local master = GetPlayerByID(mob:getLocalVar("masterID"))
    if master ~= nil then
        local ID = require("scripts/zones/"..master:getZoneName().."/IDs")
        local bf = master:getBattlefield()
        if bf ~= nil then
            if bf:getID() == 37 then -- mirror mirror
                local players = bf:getPlayers()
                bf:lose()
                for i, player in pairs(players) do
                    if player:getFellow() ~= nil then
                        player:despawnFellow()
                    end

                    player:messageSpecial(ID.text.UNABLE_TO_PROTECT)
                end
            end
        end

        master:removeListener("FELLOW_ENGAGE")
        master:removeListener("FELLOW_DISENGAGE")
    end
end

entity.onMobDespawn = function(mob)
    local master = GetPlayerByID(mob:getLocalVar("masterID"))
    local zone = mob:getZoneID()
    if
        master ~= nil and
        mob:getCurrentRegion() < 19
    then
        if
            zone ~= 16 and
            zone ~= 18 and
            zone ~= 20
        then -- no gear adjust in promys
            local maxKills      = mob:getLocalVar("maxKills")
            local zoneKills     = mob:getLocalVar("zoneKills")
            local kills         = master:getFellowValue("kills")
            --print("master: "..mob:getLocalVar("masterID").." zoneKills: "..zoneKills.." total kills: "..kills)
            local armorLock     = master:getFellowValue("armorLock")
            local regionOwner        = GetRegionOwner(mob:getCurrentRegion())
            local unlocked      = {}
            local armorTable    =
            {
                [1] = { "body" },
                [2] = { "hands" },
                [3] = { "legs" },
                [4] = { "feet" },
            }
            for i, v in ipairs(armorTable) do
                if bit.band(armorLock, bit.lshift(1, i)) == 0 then
                    table.insert(unlocked, v[1])
                end
            end

            local randomArmor   = unlocked[math.random(#unlocked)]
            if randomArmor ~= nil then -- if everything is locked - this has a bad time
                local armor =  master:getFellowValue(randomArmor)
                if zoneKills >= 15 then
                    if
                        maxKills == kills and
                        kills ~= 0
                    then
                        if regionOwner == math.floor(armor / 100) then
                            armor = armor + 1
                        else
                            armor = 0 + (regionOwner * 100)
                        end

                        if armor % 100 == 12 then
                            armor = 0 + (regionOwner * 100)
                        end
                    else
                        if regionOwner == math.floor(armor / 100) then
                            armor = (armor % 100) - 1
                            if armor < 0 then
                                armor = 0
                            end

                            armor = armor + (regionOwner * 100)
                        else
                            armor = 0 + (regionOwner * 100)
                        end
                    end
                end

                master:setFellowValue(randomArmor, armor)
            end
        end
    master:removeListener("FELLOW_ENGAGE")
    master:removeListener("FELLOW_DISENGAGE")
    end
end

return entity
