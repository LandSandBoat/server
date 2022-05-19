---------------------------------------------------------------------------------------------------
-- func: Domain
-- desc: Sends you to the next Domain Battle
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    if GetServerVariable("[Domain]NM") == 0 then
        player:setPos(-0.927, -43.600, -234.829, 195, 289)
--        player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
    end

    if GetServerVariable("[Domain]NM") == 1 then
        player:setPos(-3.202, 5.250, -19.560, 195, 292)
--        player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
    end
    
	if GetServerVariable("[Domain]NM") == 2 or
        GetServerVariable("[Domain]NM") == 3 then
        player:setPos(-582.14, -228.00, 506.58, 180, 222)
--        player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
    end
end