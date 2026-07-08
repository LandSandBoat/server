-----------------------------------
-- xi.effect.OVERDRIVE
-- https://wiki.ffo.jp/html/954.html
-- TODO: More testing on "significant resistance to status ailments" for now, gives Rank 11 resistance to status ailments during effect.
-----------------------------------
---@type TEffect
local effectObject = {}

local jobPointBonuses =
{
    [1] = xi.mod.STR,
    [2] = xi.mod.DEX,
    [3] = xi.mod.VIT,
    [4] = xi.mod.AGI,
    [5] = xi.mod.INT,
    [6] = xi.mod.MND,
    [7] = xi.mod.CHR,
}

local statusAilmentResRanks =
{
    xi.mod.PARALYZE_RES_RANK,
    xi.mod.BIND_RES_RANK,
    xi.mod.SILENCE_RES_RANK,
    xi.mod.SLOW_RES_RANK,
    xi.mod.POISON_RES_RANK,
    xi.mod.LIGHT_SLEEP_RES_RANK,
    xi.mod.DARK_SLEEP_RES_RANK,
    xi.mod.BLIND_RES_RANK,
    -- xi.mod.GRAVITY_RES_RANK,
}

local overdriveDefenseDivisors =
{
    [xi.automaton.frame.VALOREDGE ] = 24,
    [xi.automaton.frame.STORMWAKER] = 16,
    [xi.automaton.frame.SHARPSHOT ] = 18,
    [xi.automaton.frame.HARLEQUIN ] = 20,
}

effectObject.onEffectGain = function(target, effect)
    if target:getObjType() == xi.objType.PC then
        effect:addMod(xi.mod.OVERLOAD_THRESH, 5000)
        target:updateAttachments()
    end

    if target:getObjType() == xi.objType.PET then
        effect:addMod(xi.mod.HASTE_MAGIC, 2500)
        effect:addMod(xi.mod.ATTP, 25)
        effect:addMod(xi.mod.RATTP, 25)
        effect:addMod(xi.mod.ACC, 25)
        effect:addMod(xi.mod.RACC, 25)
        effect:addMod(xi.mod.EVA, 25)

        local master = target:getMaster()

        if not master then
            return
        end

        local frameEquipped = target:getAutomatonFrame()
        local frameDivisor  = overdriveDefenseDivisors[frameEquipped] or 24

        if frameDivisor then
            effect:addMod(xi.mod.DEFP, math.floor(400 / frameDivisor))
        end

        for _, mod in pairs(statusAilmentResRanks) do
            effect:addMod(mod, 11)
        end

        local jobPointBonus = master:getJobPointLevel(xi.jp.OVERDRIVE_EFFECT) * 5

        if jobPointBonus > 0 then
            for _, mod in pairs(jobPointBonuses) do
                effect:addMod(mod, jobPointBonus)
            end
        end
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if target:getObjType() == xi.objType.PC then
        target:updateAttachments()
    end
end

return effectObject
