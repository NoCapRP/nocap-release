-- this script puts certain large weapons on a player's back when it is not currently selected but still in there weapon wheel
-- by: minipunch
-- originally made for USA Realism RP (https://usarrp.net)

-- Add weapons to the 'compatable_weapon_hashes' table below to make them show up on a player's back (can use GetHashKey(...) if you don't know the hash) --
local SETTINGS = {
    back_bone = 24816,
    x = 0.075,
    y = -0.15,
    z = -0.02,
    x_rotation = 0.0,
    y_rotation = 165.0,
    z_rotation = 0.0,
    compatable_weapon_hashes = {
      -- melee:
      --["prop_golf_iron_01"] = 1141786504, -- positioning still needs work
      ["w_me_bat"] = -1786099057,
      -- ["prop_ld_jerrycan_01"] = 883325847,
      -- assault rifles:
      ["w_ar_carbinerifle"] = -2084633992,
      ["w_ar_carbineriflemk2"] = GetHashKey("WEAPON_CARBINERIFLE_Mk2"),
      ["w_ar_assaultrifle"] = -1074790547,
      ["w_ar_specialcarbine"] = -1063057011,
      ["w_ar_bullpuprifle"] = 2132975508,
      ["w_ar_advancedrifle"] = -1357824103,
      -- sub machine guns:
      ["w_sb_microsmg"] = 324215364,
      ["w_sb_assaultsmg"] = -270015777,
      ["w_sb_smg"] = 736523883,
      ["w_sb_smgmk2"] = GetHashKey("WEAPON_SMGMk2"),
      ["w_sb_gusenberg"] = 1627465347,
      -- sniper rifles:
      ["w_sr_sniperrifle"] = 100416529,
      -- shotguns:
      ["w_sg_assaultshotgun"] = -494615257,
      ["w_sg_bullpupshotgun"] = -1654528753,
      ["w_sg_pumpshotgun"] = 487013001,
      ["w_ar_musket"] = -1466123874,
      ["w_sg_heavyshotgun"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
      -- ["w_sg_sawnoff"] = 2017895192 don't show, maybe too small?
      -- launchers:
      ["w_lr_firework"] = 2138347493,
    },
    r_compatable_weapon_hashes = {
      -- melee:
      --["prop_golf_iron_01"] = 1141786504, -- positioning still needs work
      ["weapon_bat"] = -1786099057,
      -- ["prop_ld_jerrycan_01"] = 883325847,
      -- assault rifles:
      ["weapon_carbinerifle"] = -2084633992,
      -- ["w_ar_carbineriflemk2"] = GetHashKey("WEAPON_CARBINERIFLE_Mk2"),
      ["weapon_assaultrifle"] = -1074790547,
      ["weapon_specialcarbine"] = -1063057011,
      ["weapon_bullpuprifle"] = 2132975508,
      ["weapon_advancedrifle"] = -1357824103,
      ["weapon_carbinerifle"] = -2084633992,
      -- sub machine guns:
      ["weapon_microsmg"] = 324215364,
      ["weapon_assaultsmg"] = -270015777,
      ["weapon_smg"] = 736523883,
      -- ["w_sb_smgmk2"] = GetHashKey("WEAPON_SMGMk2"),
      ["weapon_gusenberg"] = 1627465347,
      -- sniper rifles:
      ["weapon_sniperrifle"] = 100416529,
      -- shotguns:
      ["weapon_assaultshotgun"] = -494615257,
      ["weapon_bullpupshotgun"] = -1654528753,
      ["weapon_pumpshotgun"] = 487013001,
      ["weapon_musket"] = -1466123874,
      ["weapon_heavyshotgun"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
      -- ["w_sg_sawnoff"] = 2017895192 don't show, maybe too small?
      -- launchers:
      ["weapon_firework"] = 2138347493,
    },
}

qbCoreToWeaponName = {
  -- ["weapon_specialcarbine"] = "w_ar_specialcarbine"
}

for k1,v1 in pairs(SETTINGS.r_compatable_weapon_hashes) do
  for k2,v2 in pairs(SETTINGS.compatable_weapon_hashes) do
    if v1 == v2 then
      qbCoreToWeaponName[k1] = k2
    end
  end
end

-- for k,v in pairs(qbCoreToWeaponName) do
--   print(k .. " " .. v)
-- end

QBCore = nil
TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end) 
-- Citizen.CreateThread(function()
--   while QBCore == nil do
--     TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
--     Citizen.Wait(200)
--   end
-- end)

local attached_weapons = {}

local firstTime = true

Citizen.CreateThread(function()
  while true do
    if QBCore ~= nil then
      local me = GetPlayerPed(-1)
      -- print("too")
      ---------------------------------------
      -- attach if player has large weapon --
      ---------------------------------------
      -- print(QBCore.Functions.GetPlayerData().inventory)
      local done = false
      QBCore.Functions.GetPlayerData(function(playerdata)
        if playerdata ~= nil and playerdata.inventory ~= nil then
          if firstTime then
            Citizen.Wait(10000)
            firstTime = false
          end
        -- print(playerdata)
          for k,v in pairs(json.decode(playerdata.inventory)) do
            if v.type == "weapon" and qbCoreToWeaponName[v.name] ~= nil then
              local wep_name = qbCoreToWeaponName[v.name]
              if wep_name ~= nil and not attached_weapons[wep_name] then
                -- print("should attach")
                local wep_hash = SETTINGS.compatable_weapon_hashes[wep_name]
                -- print(wep_name)
                -- print(wep_hash)
                if v.slot ~= 41 then 
                  AttachWeapon(wep_name, wep_hash, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(wep_name))  
                end
              end
            end
          end
          --------------------------------------------
          -- remove from back if equipped / dropped --
          --------------------------------------------
          for name, attached_object in pairs(attached_weapons) do
            -- equipped? delete it from back:
            if GetSelectedPedWeapon(me) ==  attached_object.hash then -- equipped or not in weapon wheel
              DeleteObject(attached_object.handle)
              attached_weapons[name] = nil
            end
          end
        end
        done = true
      end)

      while not done do
        Citizen.Wait(100)
      end
      
      -- for wep_name, wep_hash in pairs(SETTINGS.compatable_weapon_hashes) do
      --     if HasPedGotWeapon(me, wep_hash, false) then
      --         if not attached_weapons[wep_name] then
      --             AttachWeapon(wep_name, wep_hash, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(wep_name))
      --         end
      --     end
      -- end
      
    end
    Wait(0)
  end
end)




function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR, isMelee)
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
  }

  if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end -- reposition for melee items
  if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end
	AttachEntityToEntity(attached_weapons[attachModel].handle, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

function isMeleeWeapon(wep_name)
    if wep_name == "prop_golf_iron_01" then
        return true
    elseif wep_name == "w_me_bat" then
        return true
    elseif wep_name == "prop_ld_jerrycan_01" then
      return true
    else
        return false
    end
end
