-----------------------------------
xi = xi or {}
xi.damage = xi.damage or {}
xi.damage.magicAccuracy = xi.damage.magicAccuracy or {}
-----------------------------------
-- Modifier Tables per element.
local spellAcc          = { xi.mod.FIREACC,               xi.mod.ICEACC,               xi.mod.WINDACC,                xi.mod.EARTHACC,               xi.mod.THUNDERACC,                 xi.mod.WATERACC,              xi.mod.LIGHTACC,           xi.mod.DARKACC           }
local strongAffinityAcc = { xi.mod.FIRE_AFFINITY_ACC,     xi.mod.ICE_AFFINITY_ACC,     xi.mod.WIND_AFFINITY_ACC,      xi.mod.EARTH_AFFINITY_ACC,     xi.mod.THUNDER_AFFINITY_ACC,       xi.mod.WATER_AFFINITY_ACC,    xi.mod.LIGHT_AFFINITY_ACC, xi.mod.DARK_AFFINITY_ACC }
local rdmMerit          = { xi.merit.FIRE_MAGIC_ACCURACY, xi.merit.ICE_MAGIC_ACCURACY, xi.merit.WIND_MAGIC_ACCURACY,  xi.merit.EARTH_MAGIC_ACCURACY, xi.merit.LIGHTNING_MAGIC_ACCURACY, xi.merit.WATER_MAGIC_ACCURACY }

xi.damage.magicAccuracy.calculateCasterMagicAccuracy = function(caster, target, spell, skillType, spellElement, statDiff)
    local casterJob     = caster:getMainJob()
    local casterWeather = caster:getWeather()
    local spellGroup    = spell and spell:getSpellGroup() or xi.magic.spellGroup.NONE
    local magicAcc      = caster:getMod(xi.mod.MACC) + caster:getILvlMacc(xi.slot.MAIN)

    -- Get the base magicAcc (just skill + skill mod (79 + skillID = ModID))
    if skillType ~= 0 then
        magicAcc = magicAcc + caster:getSkillLevel(skillType)
    else
        -- For mob skills / additional effects which don't have a skill.
        magicAcc = magicAcc + utils.getSkillLvl(1, caster:getMainLvl())
    end

    if spellElement ~= xi.magic.ele.NONE then
        -- Add acc for elemental affinity accuracy and element specific accuracy
        local affinityBonus = caster:getMod(strongAffinityAcc[spellElement]) * 10
        local elementBonus  = caster:getMod(spellAcc[spellElement])
        magicAcc            = magicAcc + affinityBonus + elementBonus
    end

    -- Get dStat Magic Accuracy. NOTE: Ninjutsu does not get this bonus/penalty.
    if skillType ~= xi.skill.NINJUTSU then
        if statDiff > 10 then
            magicAcc = magicAcc + 10 + (statDiff - 10) / 2
        else
            magicAcc = magicAcc + statDiff
        end
    end

    -----------------------------------
    -- magicAcc from status effects.
    -----------------------------------
    -- Altruism
    if
        caster:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAcc = magicAcc + caster:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    -- Focalization
    if
        caster:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAcc = magicAcc + caster:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    --Add acc for klimaform
    if
        spellElement > 0 and
        caster:hasStatusEffect(xi.effect.KLIMAFORM) and
        (casterWeather == xi.magic.singleWeatherStrong[spellElement] or casterWeather == xi.magic.doubleWeatherStrong[spellElement])
    then
        magicAcc = magicAcc + 15
    end

    -- Apply Divine Emblem to Banish and Holy families
    if
        casterJob == xi.job.PLD and
        skillType == xi.skill.DIVINE_MAGIC and
        caster:hasStatusEffect(xi.effect.DIVINE_EMBLEM)
    then
        magicAcc = magicAcc + 100 -- TODO: Confirm this value in retail
    end

    -- Dark Seal
    if
        casterJob == xi.job.DRK and
        skillType == xi.skill.DARK_MAGIC and
        caster:hasStatusEffect(xi.effect.DARK_SEAL)
    then
        magicAcc = magicAcc + 256 -- Need citation. 256 seems OP
    end

    -----------------------------------
    -- magicAcc from Job Points.
    -----------------------------------
    switch (casterJob) : caseof
    {
        [xi.job.WHM] = function()
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.RDM] = function()
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skillType == xi.skill.ENFEEBLING_MAGIC and
                caster:hasStatusEffect(xi.effect.SABOTEUR)
            then
                magicAcc = magicAcc + (caster:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)) * 2
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and caster:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and caster:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = magicAcc + caster:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Merits.
    -----------------------------------
    switch (casterJob) : caseof
    {
        [xi.job.BLM] = function()
            if skillType == xi.skill.ELEMENTAL_MAGIC then
                magicAcc = magicAcc + caster:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end
        end,

        [xi.job.RDM] = function()
            -- Category 1
            if
                spellElement >= xi.magic.element.FIRE and
                spellElement <= xi.magic.element.WATER
            then
                magicAcc = magicAcc + caster:getMerit(rdmMerit[spellElement])
            end

            -- Category 2
            magicAcc = magicAcc + caster:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + caster:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
            end
        end,

        [xi.job.BLU] = function()
            if skillType == xi.skill.BLUE_MAGIC then
                magicAcc = magicAcc + caster:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Food.
    -----------------------------------
    local maccFood = magicAcc * (caster:getMod(xi.mod.FOOD_MACCP) / 100)
    magicAcc = magicAcc + utils.clamp(maccFood, 0, caster:getMod(xi.mod.FOOD_MACC_CAP))

    -----------------------------------
    -- Apply level correction and return final magic accuracy.
    -----------------------------------
    local levelDiff = utils.clamp(caster:getMainLvl() - target:getMainLvl(), -5, 5)
    magicAcc        = magicAcc + levelDiff * 3

    return magicAcc
end
