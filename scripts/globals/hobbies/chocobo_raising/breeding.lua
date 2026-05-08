-----------------------------------
-- Chocobo Raising - Breeding & Color Genetics
-----------------------------------
--
-- Glossary
-- --------
--   allele
--               One inherited copy of a color gene. Every chocobo carries three
--               alleles end-to-end; in `char_chocobos` (allele1/allele2/allele3),
--               on its chococard (dna[1..3]), and on the eggs it produces.
--               No conversion happens at hatch or retirement.
--
--   homozygous
--               All three alleles are the same color (e.g. red/red/red). The bird
--               always expresses that color and breeds true: any chick whose pool
--               is drawn purely from this side will express the same color.
--
--   heterozygous
--               At least one allele differs from the others (e.g. yellow/yellow/red,
--               or yellow/red/blue). Yellow dominates, so a bird with any yellow
--               allele looks yellow but carries hidden non-yellow alleles that can
--               surface in its offspring.
--
--   phenotype
--               The visible expression: the color you actually see on the bird.
--               In FFXI only color is a phenotype; stats and abilities have their
--               own inheritance paths.
--
--   dominant /
--   recessive
--               Yellow is dominant: any yellow allele masks every other color.
--               Non-yellow colors are recessive: a non-yellow phenotype requires
--               all three alleles to be non-yellow, with the most common color
--               winning. Ties between non-yellow colors fall to allele1.
--
-- Outcomes
-- --------
--   Y/Y/Y x Y/Y/Y                            -> 100% yellow.
--   r/r/r x r/r/r                            -> 100% red.
--   Y/Y/Y x r/r/r                            -> 5% red, 95% yellow heterozygotes.
--   Y/r/r x r/r/r (homozygous-color donor)   -> 50% red.
--   Y/r/r x Y/r/r (two heterozygotes)        -> 20% red.
--
-- Colour is rare from random pairings, but homozygous chococards can be obtained through
-- selective breeding, trade, and sale.
--
-- Sources:
--   ffxiclopedia.fandom.com/wiki/Arael's_Chocobo_Raising_Guide
--   ffxiclopedia.fandom.com/wiki/Carnivors_Guide_to_Chocobo_Breeding
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/constants')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-- Resolve a phenotype color from a 3-element dna array.
-- Yellow dominates: any yellow allele masks every other color.
-- A non-yellow phenotype requires all three alleles to be non-yellow; the most
-- common non-yellow color wins, with allele1 as the tiebreaker for determinism.
xi.chocoboRaising.allelesToColor = function(dna)
    if not dna then
        return xi.chocoboRaising.color.YELLOW
    end

    -- Yellow dominant.
    for i = 1, 3 do
        if dna[i] == xi.chocoboRaising.color.YELLOW then
            return xi.chocoboRaising.color.YELLOW
        end
    end

    -- All three non-yellow: tally and pick the most common color.
    local counts = {}
    for i = 1, 3 do
        counts[dna[i]] = (counts[dna[i]] or 0) + 1
    end

    -- allele1 is chosen first to act as the tie breaker.
    local bestColor = dna[1]
    local bestCount = counts[dna[1]]
    for color, count in pairs(counts) do
        if count > bestCount then
            bestColor = color
            bestCount = count
        end
    end

    return bestColor
end

xi.chocoboRaising.chocoStateToCardDna = function(chocoState)
    local y = xi.chocoboRaising.color.YELLOW
    if not chocoState then
        return { y, y, y }
    end

    return { chocoState.allele1 or y, chocoState.allele2 or y, chocoState.allele3 or y }
end

-- Approximately 30% non-yellow phenotype rate for shop/quest/ISNM eggs.
--
-- 70% chance of a homozygous yellow chick (Y/Y/Y); otherwise homozygous for a
-- random non-yellow color so the chick reliably expresses that color rather
-- than being masked by a yellow allele.
--
-- Source: ffxiclopedia.fandom.com/wiki/Arael's_Chocobo_Raising_Guide
--   'An egg bought or ISNMed has about a 30% chance of obtaining a color other than yellow.'
xi.chocoboRaising.rollNonBredEggAlleles = function()
    local y = xi.chocoboRaising.color.YELLOW
    if math.random(1, 100) <= 70 then
        return { y, y, y }
    end

    local nonYellow =
    {
        xi.chocoboRaising.color.BLACK,
        xi.chocoboRaising.color.BLUE,
        xi.chocoboRaising.color.RED,
        xi.chocoboRaising.color.GREEN,
    }
    local color = nonYellow[math.random(1, #nonYellow)]
    return { color, color, color }
end

-- Resolve the three alleles for a hatching chocobo. Bred eggs ship dna[1..3] via
-- exdata. Non-bred eggs (shop/quest/ISNM) carry no DNA and get freshly rolled
-- alleles via rollNonBredEggAlleles().
xi.chocoboRaising.rollEggAlleles = function(egg)
    if egg then
        local exdata = egg:getExData()
        if
            exdata and
            exdata.dna and
            #exdata.dna >= 3
        then
            return { exdata.dna[1], exdata.dna[2], exdata.dna[3] }
        end
    end

    return xi.chocoboRaising.rollNonBredEggAlleles()
end

-- Roll the chick's gender at hatch. Gourmet honeymoon plans bias toward male,
-- Hiking toward female; other plans (and non-bred eggs) are a 50/50 roll.
--
-- Source: ffxiclopedia.fandom.com/wiki/Arael's_Chocobo_Raising_Guide
--   'Gourmet and Hiking plans, respectively' (increase the chance of male / female chicks)
xi.chocoboRaising.rollEggGender = function(egg)
    local plan
    if egg then
        local exdata = egg:getExData()
        if exdata then
            plan = exdata.plan
        end
    end

    local maleChance = 50
    if plan == xi.chocoboRaising.honeymoonPlan.GOURMET then
        maleChance = 70
    elseif plan == xi.chocoboRaising.honeymoonPlan.HIKING then
        maleChance = 30
    end

    if math.random(1, 100) <= maleChance then
        return xi.chocoboRaising.gender.MALE
    end

    return xi.chocoboRaising.gender.FEMALE
end

-- Single inherited ability the chick is born with (or NONE).
-- The ability is already resolved on the egg via breedEgg(); hatching is just unpacking.
--
-- Source: ffxiclopedia.fandom.com/wiki/Arael's_Chocobo_Raising_Guide
--   'Chicks bred via matchmaking will most likely inherit one ability from one of its parents'
xi.chocoboRaising.rollEggInheritedAbility = function(egg)
    if not egg then
        return xi.chocoboRaising.ability.NONE
    end

    local exdata = egg:getExData()
    if not exdata or not exdata.ability then
        return xi.chocoboRaising.ability.NONE
    end

    return exdata.ability
end

-- Plan-driven ability bias: when a plan favours a category and at least one parent
-- has a favoured ability, prefer it from the inheritance pool. Soft preference,
-- the roll still uses the full pool when no favoured ability is present.
--
-- Source: ffxiclopedia.fandom.com/wiki/Arael's_Chocobo_Raising_Guide
--   'VCS Honeymoon Plans are really undependable' (but plans do nudge inheritance)
local planAbilityBias =
{
    [xi.chocoboRaising.honeymoonPlan.GOURMET] = nil, -- favours gender, not ability
    [xi.chocoboRaising.honeymoonPlan.SPORTS]  =      -- physical / racing
    {
        [xi.chocoboRaising.ability.GALLOP]     = true,
        [xi.chocoboRaising.ability.CANTER]     = true,
        [xi.chocoboRaising.ability.AUTO_REGEN] = true,
    },
    [xi.chocoboRaising.honeymoonPlan.HIKING]     = nil, -- favours gender, not ability
    [xi.chocoboRaising.honeymoonPlan.JEUNO_TOUR] =      -- mental / digging
    {
        [xi.chocoboRaising.ability.BURROW]          = true,
        [xi.chocoboRaising.ability.BORE]            = true,
        [xi.chocoboRaising.ability.TREASURE_FINDER] = true,
    },
}

-- Pool the 6 parent alleles (3 from each card's dna[1..3]) and draw 3 without
-- replacement. Outcomes:
--   * Two homozygous-yellow parents -> always yellow.
--   * Two homozygous-red parents    -> always red.
--   * Mixed pairings produce colored offspring with frequency proportional to the
--     non-yellow allele count in the combined pool, gated by the yellow-dominant
--     phenotype rule applied at hatch (see allelesToColor).
--
-- Drawing without replacement is implemented with a Fisher-Yates (a.k.a. Knuth)
-- shuffle: walk i from the end of the array down to 2, and at each step swap
-- pool[i] with pool[j] where j is a uniform random index in [1, i]. After the
-- loop every permutation of the 6-element pool is equally likely, so the first 3
-- entries are an unbiased sample of 3 distinct positions from the pool.
local function inheritDna(motherDna, fatherDna)
    local pool = {}

    if motherDna then
        for i = 1, math.min(3, #motherDna) do
            table.insert(pool, motherDna[i])
        end
    end

    if fatherDna then
        for i = 1, math.min(3, #fatherDna) do
            table.insert(pool, fatherDna[i])
        end
    end

    -- Pad with yellow if either parent's DNA is missing or short (e.g. legacy data).
    while #pool < 6 do
        table.insert(pool, xi.chocoboRaising.color.YELLOW)
    end

    for i = #pool, 2, -1 do
        local j = math.random(1, i)
        pool[i], pool[j] = pool[j], pool[i]
    end

    return { pool[1], pool[2], pool[3] }
end

-- Build a deduplicated, non-NONE ability pool from both parents' chococards.
local function gatherParentAbilities(motherCard, fatherCard)
    local pool = {}
    local seen = {}

    local function addAll(abilities)
        if not abilities then
            return
        end

        for _, a in ipairs(abilities) do
            if a and a ~= xi.chocoboRaising.ability.NONE and not seen[a] then
                seen[a] = true
                table.insert(pool, a)
            end
        end
    end

    addAll(motherCard and motherCard.abilities)
    addAll(fatherCard and fatherCard.abilities)

    return pool
end

-- Average receptivity rank across whichever parents have it set. Chococard receptivity
-- is an ExdataChocoboStatByteRCP { rp, rank }; rank is xi.chocoboRaising.statRank (0..7),
-- which we use directly as a coarse +chance scalar.
--
-- Source: ffxiclopedia.fandom.com/wiki/Arael's_Chocobo_Raising_Guide
--   'Receptivity ... Widely thought to influence the likelihood of passing abilities on to chicks.'
local function avgReceptivityRank(motherCard, fatherCard)
    local total, count = 0, 0

    if motherCard and motherCard.receptivity and motherCard.receptivity.rank then
        total = total + motherCard.receptivity.rank
        count = count + 1
    end

    if fatherCard and fatherCard.receptivity and fatherCard.receptivity.rank then
        total = total + fatherCard.receptivity.rank
        count = count + 1
    end

    if count == 0 then
        return 0
    end

    return total / count
end

-- Resolve which ability (if any) the egg should carry.
local function inheritAbility(motherCard, fatherCard, plan)
    local pool = gatherParentAbilities(motherCard, fatherCard)
    if #pool == 0 then
        return xi.chocoboRaising.ability.NONE
    end

    -- Inheritance chance: 60% baseline + 3% per averaged RCP rank (max +21%).
    -- 'Nowhere near guaranteed' per Arael; this lands in the 60-81% band.
    local chance = 60 + math.floor(avgReceptivityRank(motherCard, fatherCard) * 3)
    if math.random(1, 100) > chance then
        return xi.chocoboRaising.ability.NONE
    end

    -- Plan-favoured subset, if any of the parents' abilities match.
    local bias = planAbilityBias[plan]
    if bias then
        local favoured = {}
        for _, a in ipairs(pool) do
            if bias[a] then
                table.insert(favoured, a)
            end
        end

        if #favoured > 0 and math.random(1, 100) <= 70 then
            return favoured[math.random(1, #favoured)]
        end
    end

    return pool[math.random(1, #pool)]
end

-- Produce exdata for a freshly bred egg from two parent chococards and the chosen
-- VCS Honeymoon plan. Encodes inherited DNA, a single inherited ability (or NONE),
-- the plan (used at hatch for gender bias), and the bred flag.
xi.chocoboRaising.breedEgg = function(motherCard, fatherCard, plan)
    return
    {
        dna     = inheritDna(motherCard and motherCard.dna, fatherCard and fatherCard.dna),
        ability = inheritAbility(motherCard, fatherCard, plan),
        plan    = plan,
        isBred  = true,
    }
end
