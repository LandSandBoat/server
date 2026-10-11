-----------------------------------
-- Monstrosity - Feretory zone and Maccus
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- The client lists the starters as rabbit, lizard, mandragora.
local starterCutsceneIndex =
{
    [xi.monstrositySpecies.RABBIT    ] = 1,
    [xi.monstrositySpecies.LIZARD    ] = 2,
    [xi.monstrositySpecies.MANDRAGORA] = 3,
}

xi.monstrosity.feretoryOnZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local entrance = xi.monstrosity.feretoryEntrance
        player:setPos(entrance.x, entrance.y, entrance.z, entrance.rot)
    end

    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return -1
    end

    if player:getMainJob() ~= xi.job.MON then
        player:changeJob(xi.job.MON)
    end

    -- JP wiki: every effect is lost but Medicated.
    for _, effect in pairs(player:getStatusEffects()) do
        local effectType = effect:getEffectType()
        if effectType ~= xi.effect.MEDICINE then
            player:delStatusEffectSilent(effectType)
        end
    end

    return -1
end

-- Effects bought from Teyrnon survive leaving the Feretory. Zoning code may still remove some.
xi.monstrosity.feretoryOnZoneOut = function(player)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    for _, effect in pairs(player:getStatusEffects()) do
        effect:delEffectFlag(xi.effectFlag.ON_ZONE)
        effect:delEffectFlag(xi.effectFlag.LOGOUT)
    end
end

-- The Feretory introduction (event 2) draws the player's race and face, then the starter.
xi.monstrosity.updateIntroEvent = function(player)
    local starter = starterCutsceneIndex[player:getMonstrosityData().monstrosityId] or 0
    player:updateEvent(player:getRace(), player:getFace(), starter)
end

xi.monstrosity.maccusOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    -- The event is client-side dialogue only. It reads no params and returns nothing.
    player:startEvent(9)
end
