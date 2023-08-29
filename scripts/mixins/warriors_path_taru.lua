-----------------------------------
-- Warriors Path BCNM mixin for Tarus
-----------------------------------
require("scripts/globals/mixins")
-----------------------------------

g_mixins = g_mixins or {}

local taruAnimitions =
{
    [1] = { 'kuya', 'nagu', 'yoro', 'ffr1', 'awat', 'guts' },
    [2] = { 'guts', 'kuya', 'nagu', 'yoro', 'ffr1', 'awat' },
    [3] = { 'awat', 'guts', 'kuya', 'nagu', 'yoro', 'ffr1' },
}

local randChance = { 0.166, 0.333, 0.500, 0.666, 0.833, 1 }

g_mixins.warriors_path_taru = function(mob)
    mob:addListener("COMBAT_TICK", "TARU_CTICK", function(mobArg)
        local kukki = mob:getLocalVar("kukki")
        local makki = mob:getLocalVar("makki")
        local cheru = mob:getLocalVar("cheru")
        local changetime = mob:getLocalVar("changetime")
        local battletime = mob:getBattleTime()
        local ID = zones[mob:getZoneID()]
        local randOffset = math.random(0, 2) -- each taru most commonly uses text offset 0-2+ for during fight
        local animationchance = math.random()
        local battlefield = mob:getBattlefield()
        if -- every 5 seconds the taru's will say something and use a random animation
            battletime - changetime >= 5 and
            battlefield:getLocalVar("fireworks") == 0
        then
            if cheru == 1 then
                mob:showText(mob, ID.text.CHERUKIKI_OFFSET + randOffset)
                for i = 1, 6 do
                    if animationchance < randChance[i] then
                        mob:entityAnimationPacket(taruAnimitions[1][i])
                        break
                    end
                end

                mob:setLocalVar("changetime", mob:getBattleTime())
            elseif makki == 1 then
                mob:showText(mob, ID.text.MAKKI_CHEBUKKI_OFFSET + randOffset)
                for i = 1, 6 do
                    if animationchance < randChance[i] then
                        mob:entityAnimationPacket(taruAnimitions[2][i])
                        break
                    end
                end

                mob:setLocalVar("changetime", mob:getBattleTime())
            elseif kukki == 1 then
                mob:showText(mob, ID.text.KUKKI_CHEBUKKI_OFFSET + randOffset)
                for i = 1, 6 do
                    if animationchance < randChance[i] then
                        mob:entityAnimationPacket(taruAnimitions[3][i])
                        break
                    end
                end

                mob:setLocalVar("changetime", mob:getBattleTime())
            end
        end
    end)
end

return g_mixins.warriors_path_taru
