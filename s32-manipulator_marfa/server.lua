local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_constructor")

RegisterServerEvent('get:job')
AddEventHandler('get:job', function()
	local user_id = vRP.getUserId({source})
	local orejucate = vRP.getUserHoursPlayed({user_id})
	if orejucate >= 10 then
		vRP.addUserGroup({user_id, "Manipulator marfa"})
		vRPclient.notifyInfo(user_id, {"Mergi si incepe munca!"})
	else
		vRPclient.notifyError(user_id, {"Nu ai 10 ore"})
	end
end)
RegisterServerEvent('remove:job')
AddEventHandler('remove:job', function()
	local user_id = vRP.getUserId({source})
		vRP.addUserGroup({user_id, "Somer"})
		vRPclient.notifyInfo(user_id, {"Ai demisionat!"})
end)
RegisterServerEvent('primeste:factura')
AddEventHandler('primeste:factura', function()
	local user_id = vRP.getUserId({source})
	vRP.giveInventoryItem({user_id,"factura_marfa",1,true})
end)

------------------------------------------------- VINDE FACTURI -------------------------------------------------
local tdCords = { 
	[1] = { pos = {x = -435.58792114258, y = 6154.4213867188, z = 31.478054046631}} -- -435.58792114258,6154.4213867188,31.478054046631
}

local menu_confisca = {
	name = "VINDE FACTURA",
	css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
}
menu_confisca["Vinde Factura"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if(user_id ~= nil and user_id ~= "")then
		vRP.prompt({player, "Cate facturi ai?", "", function(player, factura)
			if(factura ~= "" and factura ~= nil)then
				if(tonumber(factura))then
					factura = tonumber(factura)
					if(factura > 0) and (factura <= 999)then
						if vRP.tryGetInventoryItem({user_id,"factura_marfa",factura * 1,true}) then
							local Pretfactura = math.floor(factura * 15)
							vRP.giveMoney({user_id, Pretfactura})
							vRPclient.notify(player, {"Ai vandut "..factura.." facturi pentru "..Pretfactura.." RON"})
							vRP.closeMenu({player})
						else
							vRPclient.notifyError(player, {"Nu ai destule facturi"})
						end
					else
						vRPclient.notifyError(player, {"Trebuie sa introduci un numar intre 1 si 99!"})
					end
				else
					vRPclient.notifyError(player, {"Trebuie sa introduci un numar !"})
				end
			else
				vRPclient.notifyError(player, {"Trebuie sa introduci un numar !"})
			end
		end})
	end
end, "<font color='white'> 1 Factura costa = <font color='green'>15$"}

local function build_confisca(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then

		-- local x, y, z = table.unpack(tdCords)
		for i,pos in ipairs(tdCords) do
			thepos = pos.pos

			local conf_enter = function(player, area)
				local user_id = vRP.getUserId({player})
				if user_id ~= nil then
					if menu_confisca then vRP.openMenu({player, menu_confisca}) end

				end
			end

			local conf_leave = function(player, area)
				vRP.closeMenu({player})
			end

			vRPclient.addMarker(source,{thepos.x,thepos.y,thepos.z-0.95,1,1,0.9,0, 66, 134, 244,150})
			vRP.setArea({source, "vRP:confisatdePles"..i, thepos.x,thepos.y,thepos.z, 3, 2, conf_enter, conf_leave})
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_confisca(source)
  end
end)
