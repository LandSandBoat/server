require("scripts/globals/status")
require("scripts/globals/interaction/quest")

utils = {}

-- Max uint32 constant, replaces negative values in event parameters
-- Note: If correcting a negative value, this is *already* -1, adjust accordingly!
utils.MAX_UINT32 = 4294967295
utils.MAX_INT32  = 2147483647

-- Shuffles a table and returns a copy of it, not the original.
function utils.shuffle(tab)
    local copy = {}
    for k, v in pairs(tab) do
        copy[k] = v
    end

    local res = {}
    while next(copy) do
        res[#res + 1] = table.remove(copy, math.random(#copy))
    end
    return res
end

-- Generates a random permutation of integers >= min_val and <= max_val
-- If a min_val isn't given, 1 is used (assumes permutation of lua indices)
function utils.permgen(max_val, min_val)
    local indices = {}
    min_val = min_val or 1

    if min_val >= max_val then
        for iter = min_val, max_val, -1 do
            indices[iter] = iter
        end
    else
        for iter = min_val, max_val, 1 do
            indices[iter] = iter
        end
    end

    return utils.shuffle(indices)
end

function utils.clamp(input, min_val, max_val)
    if input < min_val then
        input = min_val
    elseif max_val ~= nil and input > max_val then
        input = max_val
    end
    return input
end

-- returns unabsorbed damage
function utils.stoneskin(target, dmg)
    --handling stoneskin
    if dmg > 0 then
        local skin = target:getMod(xi.mod.STONESKIN)
        if skin > 0 then
            if skin > dmg then --absorb all damage
                target:delMod(xi.mod.STONESKIN, dmg)
                return 0
            else --absorbs some damage then wear
                target:delStatusEffect(xi.effect.STONESKIN)
                target:setMod(xi.mod.STONESKIN, 0)
                return dmg - skin
            end
        end
    end

    return dmg
end

function utils.takeShadows(target, dmg, shadowbehav)
    if shadowbehav == nil then
        shadowbehav = 1
    end

    local targShadows = target:getMod(xi.mod.UTSUSEMI)
    local shadowType = xi.mod.UTSUSEMI

    if targShadows == 0 then
        --try blink, as utsusemi always overwrites blink this is okay
        targShadows = target:getMod(xi.mod.BLINK)
        shadowType = xi.mod.BLINK
    end

    local shadowsLeft = targShadows
    local shadowsUsed = 0

    if targShadows > 0 then
        if shadowType == xi.mod.BLINK then
            for i = 1, shadowbehav, 1 do
                if shadowsLeft > 0 then
                    if math.random() <= 0.8 then
                        shadowsUsed = shadowsUsed + 1
                        shadowsLeft = shadowsLeft - 1
                    end
                end
            end

            if shadowsUsed >= shadowbehav then
                dmg = 0
            else
                dmg = (dmg / shadowbehav) * (shadowbehav - shadowsUsed)
            end
        else
            if targShadows >= shadowbehav then
                shadowsLeft = targShadows - shadowbehav

                if shadowsLeft > 0 then
                    --update icon
                    local effect = target:getStatusEffect(xi.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if shadowsLeft == 1 then
                            effect:setIcon(xi.effect.COPY_IMAGE)
                        elseif shadowsLeft == 2 then
                            effect:setIcon(xi.effect.COPY_IMAGE_2)
                        elseif shadowsLeft == 3 then
                            effect:setIcon(xi.effect.COPY_IMAGE_3)
                        end
                    end
                end

                dmg = 0
            else
                shadowsLeft = 0
                dmg = dmg * (shadowbehav - targShadows) / shadowbehav
            end
        end

        target:setMod(shadowType, shadowsLeft);

        if shadowsLeft <= 0 then
            target:delStatusEffect(xi.effect.COPY_IMAGE)
            target:delStatusEffect(xi.effect.BLINK)
        end
    end

    return dmg
end

function utils.conalDamageAdjustment(attacker, target, skill, max_damage, minimum_percentage)
    local final_damage = 1
    -- #TODO: Currently all cone attacks use static 45 degree (360 scale) angles in core, when cone attacks
    -- have different angles and there's a method to fetch the angle, use a line like the below
    -- local cone_angle = skill:getConalAngle()
    local cone_angle = 32 -- 256-degree based, equivalent to "45 degrees" on 360 degree scale

    -- #TODO: Conal attacks hit targets in a cone with a center line of the "primary" target (the mob's
    -- highest enmity target). These primary targets can be within 128 degrees of the mob's front. However,
    -- there's currently no way for a conal skill to store (and later check) the primary target a mob skill
    -- was trying to hit. Therefore the "damage drop off" here is based from an origin of the mob's rotation
    -- instead. Should conal skills become capable of identifying their primary target, this should be changed
    -- to be based on the degree difference from the primary target instead.
    local conal_angle_power = cone_angle - math.abs(attacker:getFacingAngle(target))

    if conal_angle_power < 0 then
        -- #TODO The below print will be a valid print upon fixing to-do above relating to beam center orgin
        -- print("Error: conalDamageAdjustment - Mob TP move hit target beyond conal angle: ".. cone_angle)
        conal_angle_power = 0
    end

    -- Calculate the amount of damage to add above the minimum percentage based on how close
    -- the target is to the center of the conal (0 degrees from the attacker's facing)
    local minimum_damage = max_damage * minimum_percentage
    local damage_per_angle = (max_damage - minimum_damage) / cone_angle
    local additional_damage = damage_per_angle * conal_angle_power

    final_damage = math.max(1, math.ceil(minimum_damage + additional_damage))

    return final_damage
end

-- returns true if taken by third eye
function utils.thirdeye(target)
    --third eye doesnt care how many shadows, so attempt to anticipate, but reduce
    --chance of anticipate based on previous successful anticipates.
    local teye = target:getStatusEffect(xi.effect.THIRD_EYE)

    if teye == nil then
        return false
    end

    local prevAnt = teye:getPower()

    if prevAnt == 0 or (math.random() * 100) < (80 - (prevAnt * 10)) then
        --anticipated!
        target:delStatusEffect(xi.effect.THIRD_EYE)
        return true
    end

    return false
end

-----------------------------------
--     SKILL LEVEL CALCULATOR
--     Returns a skill level based on level and rating.
--
--    See the translation of aushacho's work by Themanii:
--    http://home.comcast.net/~themanii/skill.html
--
--    The arguments are skill rank (numerical), and level.  1 is A+, 2 is A-, and so on.
-----------------------------------

-- skillLevelTable contains matched pairs based on rank; First value is multiplier, second is additive value.  Index is the subtracted
-- baseInRange value (see below)
-- Original formula: ((level - <baseInRange>) * <multiplier>) + <additive>; where level is a range defined in utils.getSkillLvl
local skillLevelTable =
{
    --        A+           A-           B+           B            B-           C+           C            C-           D            E            F
    [1]  = { {3.00,   6}, {3.00,   6}, {2.90,   5}, {2.90,   5}, {2.90,   5}, {2.80,   5}, {2.80,   5}, {2.80,   5}, {2.70,   4}, {2.50,   4}, {2.30,   4} }, -- Level <= 50
    [50] = { {5.00, 153}, {5.00, 153}, {4.90, 147}, {4.90, 147}, {4.90, 147}, {4.80, 142}, {4.80, 142}, {4.80, 142}, {4.70, 136}, {4.50, 126}, {4.30, 116} }, -- Level > 50 and Level <= 60
    [60] = { {4.85, 203}, {4.10, 203}, {3.70, 196}, {3.23, 196}, {2.70, 196}, {2.50, 190}, {2.25, 190}, {2.00, 190}, {1.85, 183}, {1.95, 171}, {2.05, 159} }, -- Level > 60 and Level <= 70
    [70] = { {5.00, 251}, {5.00, 244}, {3.70, 233}, {3.23, 228}, {2.70, 223}, {3.00, 215}, {2.60, 212}, {2.00, 210}, {1.85, 201}, {1.95, 190}, {2.00, 179} }, -- Level > 70
}

-- Get the corresponding table entry to use in skillLevelTable based on level range
-- TODO: Minval for ranges 2 and 3 in the conditional is probably not necessary
local function getSkillLevelIndex(level)
    local rangeId = nil

    if level <= 50 then
        rangeId = 1
    elseif level > 50 and level <= 60 then
        rangeId = 50
    elseif level > 60 and level <= 70 then
        rangeId = 60
    else
        rangeId = 70
    end

    return rangeId
end

function utils.getSkillLvl(rank, level)
    local levelTableIndex = getSkillLevelIndex(level)
    return ((level - levelTableIndex) * skillLevelTable[levelTableIndex][rank][1]) + skillLevelTable[levelTableIndex][rank][2]
end

function utils.getMobSkillLvl(rank, level)
     if level > 50 then
         if rank == 1 then
             return 153 + (level - 50) * 5
         end
         if rank == 2 then
             return 147 + (level - 50) *4.9
         end
         if rank == 3 then
             return 136 + (level - 50) * 4.8
         end
         if rank == 4 then
             return 126 + (level - 50) * 4.7
         end
         if rank == 5 then
             return 116 + (level - 50) * 4.5
         end
         if rank == 6 then
             return 106 + (level - 50) * 4.4
         end
         if rank == 7 then
             return 96 + (level - 50) * 4.3
         end
     end

     if rank == 1 then
         return 6 + (level - 1) * 3
     end
     if rank == 2 then
         return 5 + (level - 1) * 2.9
     end
     if rank == 3 then
         return 5 + (level - 1) * 2.8
     end
     if rank == 4 then
         return 4 + (level - 1) * 2.7
     end
     if rank == 5 then
         return 4 + (level - 1) * 2.5
     end
     if rank == 6 then
         return 3 + (level - 1) * 2.4
     end
     if rank == 7 then
         return 3 + (level - 1) * 2.3
     end
    return 0
end

-- System Strength Bonus table.  This is used by MobBreathMove, but determines weakness of
-- a definding system, vs the attacking system.  This table is indexed by the attacker.
-- This table can scale beyond two values, but at this time, no data has been recorded.
-- Values: 1 == Bonus, -1 == Weakness, 0 == Default (No Weakness or Bonus)
local systemStrengthTable =
{
    [xi.eco.BEAST   ] = { [xi.eco.LIZARD  ] = 1, [xi.eco.PLANTOID] = -1, },
    [xi.eco.LIZARD  ] = { [xi.eco.VERMIN  ] = 1, [xi.eco.BEAST   ] = -1, },
    [xi.eco.VERMIN  ] = { [xi.eco.PLANTOID] = 1, [xi.eco.LIZARD  ] = -1, },
    [xi.eco.PLANTOID] = { [xi.eco.BEAST   ] = 1, [xi.eco.VERMIN  ] = -1, },
    [xi.eco.AQUAN   ] = { [xi.eco.AMORPH  ] = 1, [xi.eco.BIRD    ] = -1, },
    [xi.eco.AMORPH  ] = { [xi.eco.BIRD    ] = 1, [xi.eco.AQUAN   ] = -1, },
    [xi.eco.BIRD    ] = { [xi.eco.AQUAN   ] = 1, [xi.eco.AMORPH  ] = -1, },
    [xi.eco.UNDEAD  ] = { [xi.eco.ARCANA  ] = 1, },
    [xi.eco.ARCANA  ] = { [xi.eco.UNDEAD  ] = 1, },
    [xi.eco.DRAGON  ] = { [xi.eco.DEMON   ] = 1, },
    [xi.eco.DEMON   ] = { [xi.eco.DRAGON  ] = 1, },
    [xi.eco.LUMORIAN] = { [xi.eco.LUMINION] = 1, },
    [xi.eco.LUMINION] = { [xi.eco.LUMORIAN] = 1, },
}

function utils.getSystemStrengthBonus(attacker, defender)
    local attackerSystem = attacker:getSystem()
    local defenderSystem = defender:getSystem()

    for k, v in pairs(systemStrengthTable) do
        if k == attackerSystem then
            for defId, weakValue in pairs(systemStrengthTable[k]) do
                if defId == defenderSystem then
                    return weakValue
                end
            end
        end
    end

    return 0
end

-- utils.mask contains functions for bitmask variables
utils.mask =
{
    -- return mask's pos-th bit as bool
    getBit = function(mask, pos)
        return bit.band(mask, bit.lshift(1, pos)) ~= 0
    end,

    -- return value of mask after setting its pos-th bit
    -- val can be bool or number.  if number, any non-zero value will be treated as true.
    setBit = function(mask, pos, val)
        local state = false

        if type(val) == "boolean" then
            state = val
        elseif type(val) == "number" then
            state = (val ~= 0)
        end

        if state then
            -- turn bit on
            return bit.bor(mask, bit.lshift(1, pos))
        else
            -- turn bit off
            return bit.band(mask, bit.bnot(bit.lshift(1, pos)))
        end
    end,

    -- return number of true bits in mask of length len
    -- if len is omitted, assume 32
    countBits = function(mask, len)
        if not len then
            len = 32
        end

        local count = 0

        for i = 0, len - 1 do
            count = count + bit.band(bit.rshift(mask, i), 1)
        end

        return count
    end,

    -- are all bits true in mask of length len?
    -- if len is omitted, assume 32
    isFull = function(mask, len)
        if not len then
            len = 32
        end

        local fullMask = (2 ^ len) - 1

        return bit.band(mask, fullMask) == fullMask
    end,
}

function utils.prequire(...)
    local ok, result = pcall(require, ...)
    if ok then
        return result
    else
        local vars = {...}
        printf("Error while trying to load '%s': %s", vars[1], result)
    end
end

function utils.contains(value, collection)
    for _, v in collection do
        if value == v then
            return true
        end
    end

    return false
end

-- Selects a random entry from a table, returns the index and the entry
-- https://gist.github.com/jdev6/1e7ff30671edf88d03d4
function utils.randomEntry(t)
    local keys = {}
    local values = {}
    for key, value in pairs(t) do
        keys[#keys+1] = key
        values[#values+1] = value
    end
    local index = keys[math.random(1, #keys)]
    return index, t[index]
end

-- Helper functions for Interaction Framework Quests
-- These should only be used when working between quests, or outside
-- of the quest script itself.  Quest vars will be deleted automatically
-- when that quest:complete(player) is called!

function utils.getQuestVar(player, logId, questId, varName)
    local charVarName = Quest.getVarPrefix(logId, questId) .. varName
    return player:getCharVar(charVarName)
end

function utils.setQuestVar(player, logId, questId, varName, value)
    local charVarName = Quest.getVarPrefix(logId, questId) .. varName
    player:setCharVar(charVarName, value)
end

-- Used to keep the linter quiet
function utils.unused(...)
    return
end
