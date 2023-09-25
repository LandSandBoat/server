-----------------------------------
-- Allow custom rate of exp scrolls.
-----------------------------------
local m = Module:new("custom_scroll_exp_rate")

-- Only apply overrides if the config is present and meaningful
if
    xi.settings.main.SCROLL_EXP_RATE and
    xi.settings.main.SCROLL_EXP_RATE ~= 1
then
    m:addOverride("xi.globals.items.copy_of_ginuvas_battle_theory.onItemUse", function(target)
        target:addExp(xi.settings.main.EXP_RATE * math.random(50, 200) * xi.settings.main.SCROLL_EXP_RATE)
    end)

    m:addOverride("xi.globals.items.copy_of_schultz_stratagems.onItemUse", function(target)
        target:addExp(xi.settings.main.EXP_RATE * math.random(150, 500) * xi.settings.main.SCROLL_EXP_RATE)
    end)

    m:addOverride("xi.globals.items.page_from_balrahns_reflections.onItemUse", function(target)
        target:addExp(xi.settings.main.EXP_RATE * math.random(200, 500) * xi.settings.main.SCROLL_EXP_RATE)
    end)

    m:addOverride("xi.globals.items.page_from_miratetes_memoirs.onItemUse", function(target)
        target:addExp(xi.settings.main.EXP_RATE * math.random(750, 1500) * xi.settings.main.SCROLL_EXP_RATE)
    end)

    m:addOverride("xi.globals.items.page_from_the_dragon_chronicles.onItemUse", function(target)
        target:addExp(xi.settings.main.EXP_RATE * math.random(500, 1000) * xi.settings.main.SCROLL_EXP_RATE)
    end)
end

return m
