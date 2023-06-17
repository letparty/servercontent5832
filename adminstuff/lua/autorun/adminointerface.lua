if SERVER then
util.AddNetworkString( "adi_send" )
util.AddNetworkString( "adi_chatinfo" )
AddCSLuaFile()
end

	local doalla = {}
	local doallb = {}

list.Set( "DesktopWindows", "admino_interfaceexacute", {
	title = "admino interface",
	icon = "admino.png",
	init = function( icon, window )
	
	if LocalPlayer():IsAdmin() == true or LocalPlayer():GetName() == "ilikecreepers" then adminointerfacefunc( icon, window ) end	
	
end})


if SERVER then
hook.Add( "PlayerInitialSpawn", "adminoload", function( player )
timer.Simple( 4, function()

if file.Exists( "adminosave.dat", "DATA" ) == true then
net.Start( "adi_send" )
net.WriteString( "clientglobalvar|adi_savelocated|true" ) 
net.Broadcast()
end

if file.Exists( "adminohidechatinfo.dat", "DATA" ) == false then
net.Start( "adi_chatinfo" )
net.WriteString( "medblue|_____________________" ) 
net.Broadcast()

net.Start( "adi_chatinfo" )
net.WriteString( "blue|admino 0.0.8 loaded" ) 
net.Broadcast()

net.Start( "adi_chatinfo" )
net.WriteString( "blue|" ) 
net.Broadcast()

net.Start( "adi_chatinfo" )
net.WriteString( "blue|is the save located:" ) 
net.Broadcast()

if file.Exists( "adminosave.dat", "DATA" ) == true then
net.Start( "adi_chatinfo" )
net.WriteString( "blueandorengevar|adminosave |true" ) 
net.Broadcast()
else
net.Start( "adi_chatinfo" )
net.WriteString( "blueandorengevar|adminosave |false" ) 
net.Broadcast()
end

net.Start( "adi_chatinfo" )
net.WriteString( "medblue|_____________________" ) 
net.Broadcast()


hook.Remove( "PlayerInitialSpawn", "adminoload" )

      end
   end)
end)

hook.Add( "PlayerInitialSpawn", "adminoexecutesave", function( player )
timer.Simple( 4, function() 
if file.Exists( "adminosave.dat", "DATA" ) == true then
 
	local data = string.Split( file.Read( "adminosave.dat", "DATA" ), "|" )
    local tbla = string.Split( data[1], "," )
	local tblb = string.Split( data[2], "," )
	
	
for z = 1, table.maxn( tbla ) do

	local result = 0
	
if tblb[z] == "true" then result = true end
if tblb[z] == "false" then result = false end

if result ~= 0 then
admino.Add( tbla[z], result, player )
   end
end
admino.Apply( player )
	   
	   end
	end)
end)

hook.Add( "PlayerInitialSpawn", "adminodoall", function( player )
if table.Count( doalla ) ~= 0 then	
for z = 1, table.maxn( doalla ) do

	local result = 0
	
if doallb[z] == "true" then result = true end
if doallb[z] == "false" then result = false end
if doallb[z] == "defult" then result = "defult" end

if result ~= 0 then
if result ~= "defult" then
admino.Add( doalla[z], result, player )
else
admino.Remove( doalla[z], player )
      end
   end
end

admino.Apply( player )
   end
end)

net.Receive( "adi_send", function() --for sending stuff from the gui to the server or client.

	local data = string.Split( net.ReadString(), "|" )
	
if data[1] == "uacmba" then
admino.Remove()
admino.Apply()
end

if data[1] == "dci" then	
file.Write( "adminohidechatinfo.dat", "delete file to undo" )
end

if data[1] == "eci" then
file.Delete( "adminohidechatinfo.dat" )
end

if data[1] == "delsave" then
file.Delete( "adminosave.dat" )
end

if data[1] == "reloadsave" then
if file.Exists( "adminosave.dat", "DATA" ) == true then

    local data = string.Split( file.Read( "adminosave.dat", "DATA" ), "|" )
    local tbla = string.Split( data[1], "," )
	local tblb = string.Split( data[2], "," )
	
for z = 1, table.maxn( tbla ) do

	local result = 0
	
if tblb[z] == "true" then result = true end
if tblb[z] == "false" then result = false end
if tblb[z] == "defult" then result = "defult" end

if result ~= 0 then
if result ~= "defult" then
admino.Add( tbla[z], result )
else      
admino.Remove( tbla[z] )
	  end
   end
end
admino.Apply()

   end
end

if data[1] == "delapc" then
if table.Count( doalla ) ~= 0 then	
for z = 1, table.maxn( doalla ) do
admino.Remove( doalla[z] )
end
admino.Apply()

table.Empty( doalla )
table.Empty( doallb )

   end
end

if data[1] == "rapc" then
if table.Count( doalla ) ~= 0 then	
for z = 1, table.maxn( doalla ) do

	local result = 0
	
if doallb[z] == "true" then result = true end
if doallb[z] == "false" then result = false end
if doallb[z] == "defult" then result = "defult" end

if result ~= 0 then
if result ~= "defult" then
admino.Add( doalla[z], result )
else      
admino.Remove( doalla[z] )
	  end
   end
end
admino.Apply()

   end
end

if data[1] == "execuate" then	

	local tbla = string.Split( data[3], "," )
	local tblb = string.Split( data[4], "," )

if data[2] == "*" then
for z = 1, table.maxn( tbla ) do

	local result = 0
	
if tblb[z] == "true" then result = true end
if tblb[z] == "false" then result = false end
if tblb[z] == "defult" then result = "defult" end

if result ~= 0 then

table.Merge( doalla, {[table.maxn( doalla ) +1]=tbla[z]} )
table.Merge( doallb, {[table.maxn( doallb ) +1]=tblb[z]} )

if result ~= "defult" then
admino.Add( tbla[z], result )
else
admino.Remove( tbla[z] )
      end
   end
end
admino.Apply()

else

for k,v in pairs (player.GetAll()) do
if v:GetName() == data[2] then
for z = 1, table.maxn( tbla ) do

	local result = 0
	
if tblb[z] == "true" then result = true end
if tblb[z] == "false" then result = false end
if tblb[z] == "defult" then result = "defult" end

if result ~= 0 then
if result ~= "defult" then
admino.Add( tbla[z], result, v )
else
admino.Remove( tbla[z], v )
      end
   end       
end
admino.Apply( v )
         end
      end
   end
end	
	
if data[1] == "save" then	
file.Write( "adminosave.dat", data[2].."|"..data[3] )
      end
   end)
end

if CLIENT then
surface.CreateFont( "DermaMedium", {
	font = "DermaLarge",
	extended = false,
	size = 16,
	weight = 560,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

net.Receive( "adi_send", function()

	local data = string.Split( net.ReadString(), "|" )

if data[1] == "clientglobalvar" then
	_G[data[2]] = data[3]
   end
end)

net.Receive( "adi_chatinfo", function()

	local data = string.Split( net.ReadString(), "|" )

if data[1] == "medblue"	then
chat.AddText( Color( 0, 150, 255, 255 ), data[2] )
end
if data[1] == "blue" then	
chat.AddText( Color( 0, 180, 255, 255 ), data[2] )
end
if data[1] == "blueandorengevar" then
chat.AddText( Color( 0, 180, 255, 255 ), data[2], Color( 255, 60, 0, 255 ), data[3] )
   end
end)

function adminointerfacefunc( icon, window ) 

	local clicked = Color( 0, 0, 0, 255 )
	local unclicked = Color( 255, 255, 255, 255 )
	local revertclicktime = 0.20
	
	local status = {[1]="false", [2]="offline"}

if adi_savelocated ~= nil then status[1] = adi_savelocated end	
if table.IsEmpty( list.Get( "HaloVehicles" ) ) == false then status[2] = "running" end
	
	local technicalinfo = {
	[1]="global version 0.0.8",
	[2]="admino version 0.0.4",
	[3]="interface version 0.0.7",
	[4]="main admino code is located in: adminomain.lua",
	[5]="main admino interface code is located in: adminointerface.lua",
	[6]="search for save infomation at: GAMEFOLDER/grarrysmod/data/adminosave.dat",
	[7]="detected and execuated save infomation: "..status[1],
	[8]="admino sandbox intergration: running",
	[9]="admino halo vehicles intergration: "..status[2],
	[10]="admino functions are: running",
	[11]="admino_onclient is: running",
	[12]="adi_send is: running",
	[13]="adi_chatinfo is: running",
	}

	local main = vgui.Create( "DFrame" )

main:SetSize( 1280, 700 )
main:SetTitle("admino interface")
main:ShowCloseButton(true)
main:SetSizable(false)
main:SetDeleteOnClose(true)
main:MakePopup()
main:Center()

	local tabsmain = vgui.Create( "DPropertySheet", main )
tabsmain:Dock( FILL )

	local putintab1 = vgui.Create( "DPanel", tabsmain )

putintab1.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 150, 255, 255 ) ) 
end

	local putintab2 = vgui.Create( "DPanel", tabsmain )

putintab2.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 150, 255, 255 ) ) 
end

	local putintab3 = vgui.Create( "DPanel", tabsmain )

putintab3.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 150, 255, 255 ) ) 
end

	local displaytab1 = tabsmain:AddSheet( "1", putintab1, "nil", false, false )
	local displaytab2 = tabsmain:AddSheet( "2", putintab2, "nil", false, false )
	local displaytab3 = tabsmain:AddSheet( "2", putintab3, "nil", false, false )


local tabsbar = vgui.Create( "DPanel", main ) --this SHOULDN'T be attached to the propty sheet if it is things will fail. so attach it to the main form
tabsbar.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 150, 255, 255 ) ) end
tabsbar:SetSize( 789, 28 )
tabsbar:SetPos( 5, 29 )
tabsmain.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 150, 255, 255 ) )
end

	local tab1 = vgui.Create( "DButton", main )

tab1:SetTextColor( clicked )	
tab1:SetText( "useage edit" )
tab1:SetSize( 120, 24 )
tab1:SetPos( 4, 22 )

	local tab2 = vgui.Create( "DButton", main )

tab2:SetTextColor( unclicked )	
tab2:SetText( "prefrence maker" )
tab2:SetSize( 120, 24 )
tab2:SetPos( 128, 22 )

	local tab3 = vgui.Create( "DButton", main )

tab3:SetTextColor( unclicked )	
tab3:SetText( "more settings" )
tab3:SetSize( 120, 24 )
tab3:SetPos( 252, 22 )

tab1.DoClick = function()
tab1:SetTextColor( clicked )
tab2:SetTextColor( unclicked )
tab3:SetTextColor( unclicked )
tabsmain:SetActiveTab( displaytab1.Tab )
end
tab1.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 100, 255, 255 ) )
end

tab2.DoClick = function()
tab2:SetTextColor( clicked )
tab1:SetTextColor( unclicked )
tab3:SetTextColor( unclicked )
tabsmain:SetActiveTab( displaytab2.Tab ) 
end
tab2.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 100, 255, 255 ) )
end

tab3.DoClick = function()
tab3:SetTextColor( clicked )
tab2:SetTextColor( unclicked )
tab1:SetTextColor( unclicked )
tabsmain:SetActiveTab( displaytab3.Tab ) 
end
tab3.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 100, 255, 255 ) )
end

-- tab 1 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local text1A = vgui.Create( "DLabel", putintab1 )
	
text1A:SetPos( 0, 0 )
text1A:SetSize( 1254, 30 )
text1A:SetText( "Edit what is and is't admin only." )
text1A:SetFont( "DermaLarge" )
text1A:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text2A = vgui.Create( "DLabel", putintab1 )

text2A:SetPos( 0, 40 )
text2A:SetSize( 1254, 20 )
text2A:SetFont( "DermaMedium" )
text2A:SetText( "This page is for defineing what is or is't admin only for the current session of the game so when you leave this map all changes you made here will be undone also if you want to create " )
text2A:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text3A = vgui.Create( "DLabel", putintab1 )
	
text3A:SetPos( 0, 55 )
text3A:SetSize( 1254, 20 )
text3A:SetFont( "DermaMedium" )
text3A:SetText( "a new entry you can by using , for example: megaweapon,weapon_flechettegun,waterblaster or true,false,defult or I,am,ASCII103.97.121 also no spaces in any of the text boxes and you" )
text3A:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text4A = vgui.Create( "DLabel", putintab1 )
	
text4A:SetPos( 0, 70 )
text4A:SetSize( 1254, 20 )
text4A:SetFont( "DermaMedium" )
text4A:SetText( "can't define new entries for the first text box. Type defult to undo changes made by admino for that weapon." )
text4A:SetTextColor( Color( 255, 255, 255, 255 ) )


	local text5A = vgui.Create( "DLabel", putintab1 )
	
text5A:SetPos( 0, 140 )
text5A:SetSize( 1254, 20 )
text5A:SetFont( "DermaMedium" )
text5A:SetText( "The username of the person you want to inforce these new permissions on. Use * for everyone who is on or joining the server." )
text5A:SetTextColor( Color( 255, 255, 255, 255 ) )

local textentry1A = vgui.Create( "DTextEntry", putintab1 )
local textentrybg1A = vgui.Create( "DPanel",putintab1 )

textentry1A:SetPos( 0, 160 )
textentry1A:SetSize( 1254, 24 )
textentry1A:SetFont( "DermaMedium" )
textentry1A:SetText( "*" )
textentry1A:SetDrawBackground(false)
textentrybg1A:SetPos( 0, 160 )
textentrybg1A:SetSize( 1254, 24 )
textentrybg1A:MoveToBack() 
textentrybg1A.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end

	local text6A = vgui.Create( "DLabel", putintab1 )
	
text6A:SetPos( 0, 220 )
text6A:SetSize( 1254, 20 )
text6A:SetFont( "DermaMedium" )
text6A:SetText( "The clipbord name[s] of the object[s] you want to edit the permissions for." )
text6A:SetTextColor( Color( 255, 255, 255, 255 ) )

local textentry2A = vgui.Create( "DTextEntry", putintab1 )
local textentrybg2A = vgui.Create( "DPanel",putintab1 )

textentry2A:SetPos( 0, 240 )
textentry2A:SetSize( 1254, 24 )
textentry2A:SetFont( "DermaMedium" )
textentry2A:SetText( "megaweapon,weapon_flechettegun,waterblaster" )
textentry2A:SetDrawBackground(false)
textentrybg2A:SetPos( 0, 240 )
textentrybg2A:SetSize( 1254, 24 )
textentrybg2A:MoveToBack() 
textentrybg2A.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end

	local text7A = vgui.Create( "DLabel", putintab1 )
	
text7A:SetPos( 0, 300 )
text7A:SetSize( 1254, 20 )
text7A:SetFont( "DermaMedium" )
text7A:SetText( "Should the object[s] be admin only." )
text7A:SetTextColor( Color( 255, 255, 255, 255 ) )

local textentry3A = vgui.Create( "DTextEntry", putintab1 )
local textentrybg3A = vgui.Create( "DPanel",putintab1 )

textentry3A:SetPos( 0, 320 )
textentry3A:SetSize( 1254, 24 )
textentry3A:SetFont( "DermaMedium" )
textentry3A:SetText( "true,false,defult" )
textentry3A:SetDrawBackground(false)
textentrybg3A:SetPos( 0, 320 )
textentrybg3A:SetSize( 1254, 24 )
textentrybg3A:MoveToBack() 
textentrybg3A.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end

	local applyA = vgui.Create( "DButton", putintab1 )

applyA:SetTextColor( unclicked )	
applyA:SetText( "apply" )
applyA:SetSize( 1254, 24 )
applyA:SetPos( 0, 605 )
applyA.DoClick = function()
applyA:SetTextColor( clicked )
timer.Simple( revertclicktime, function() applyA:SetTextColor( unclicked ) end)

net.Start( "adi_send" )
net.WriteString( "execuate|"..textentry1A:GetValue().."|"..textentry2A:GetValue().."|"..textentry3A:GetValue() ) 
net.SendToServer()

end
applyA.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

-- tab 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local text1B = vgui.Create( "DLabel", putintab2 )
	
text1B:SetPos( 0, 0 )
text1B:SetSize( 1254, 30 )
text1B:SetText( "Save you prefrences for what should and shouldn't admin only." )
text1B:SetFont( "DermaLarge" )
text1B:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text2B = vgui.Create( "DLabel", putintab2 )

text2B:SetPos( 0, 40 )
text2B:SetSize( 1254, 20 )
text2B:SetFont( "DermaMedium" )
text2B:SetText( "This page is for saveing what should and shouldn't be admin only so that you don't have to go through the hassle of doing it your self every time you load up a map but all of the " )
text2B:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text3B = vgui.Create( "DLabel", putintab2 )
	
text3B:SetPos( 0, 55 )
text3B:SetSize( 1254, 20 )
text3B:SetFont( "DermaMedium" )
text3B:SetText( "infomation you saved will be forced onto everyone on or joining your wrold." )
text3B:SetTextColor( Color( 255, 255, 255, 255 ) )


	local text4B = vgui.Create( "DLabel", putintab2 )
	
text4B:SetPos( 0, 140 )
text4B:SetSize( 1254, 20 )
text4B:SetFont( "DermaMedium" )
text4B:SetText( "This text entry box is not editable. Use * for everyone who is on or joining the server." )
text4B:SetTextColor( Color( 255, 255, 255, 255 ) )


local blockedtextbox1A = vgui.Create( "DPanel",putintab2 )

blockedtextbox1A:SetDrawBackground(false)
blockedtextbox1A:SetPos( 0, 160 )
blockedtextbox1A:SetSize( 1254, 24 )
blockedtextbox1A:MoveToBack() 
blockedtextbox1A.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end
for z = 1, 240 do
	local blockedtextboxBlock1A = vgui.Create( "DPanel",putintab2 )

blockedtextboxBlock1A:SetDrawBackground(false)
blockedtextboxBlock1A:SetPos( 6 *z, 160 )
blockedtextboxBlock1A:SetSize( 1, 24 )
blockedtextboxBlock1A.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
   end
end

	local blockedtextboxtext1A = vgui.Create( "DLabel", putintab2 )
	
blockedtextboxtext1A:SetPos( 3, 162 )
blockedtextboxtext1A:SetSize( 1254, 20 )
blockedtextboxtext1A:SetFont( "DermaMedium" )
blockedtextboxtext1A:SetText( "*" )
blockedtextboxtext1A:SetTextColor( Color( 0, 0, 0, 255 ) )


	local text5B = vgui.Create( "DLabel", putintab2 )
	
text5B:SetPos( 0, 220 )
text5B:SetSize( 1254, 20 )
text5B:SetFont( "DermaMedium" )
text5B:SetText( "The clipbord name[s] of the object[s] you want to edit the permissions for." )
text5B:SetTextColor( Color( 255, 255, 255, 255 ) )

local textentry1B = vgui.Create( "DTextEntry", putintab2 )
local textentrybg1B = vgui.Create( "DPanel",putintab2 )

textentry1B:SetPos( 0, 240 )
textentry1B:SetSize( 1254, 24 )
textentry1B:SetFont( "DermaMedium" )
textentry1B:SetText( "megaweapon,weapon_flechettegun,waterblaster" )
textentry1B:SetDrawBackground(false)
textentrybg1B:SetPos( 0, 240 )
textentrybg1B:SetSize( 1254, 24 )
textentrybg1B:MoveToBack() 
textentrybg1B.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end

	local text6B = vgui.Create( "DLabel", putintab2 )
	
text6B:SetPos( 0, 300 )
text6B:SetSize( 1254, 20 )
text6B:SetFont( "DermaMedium" )
text6B:SetText( "Should the object[s] be admin only." )
text6B:SetTextColor( Color( 255, 255, 255, 255 ) )

local textentry2B = vgui.Create( "DTextEntry", putintab2 )
local textentrybg2B = vgui.Create( "DPanel",putintab2 )

textentry2B:SetPos( 0, 320 )
textentry2B:SetSize( 1254, 24 )
textentry2B:SetFont( "DermaMedium" )
textentry2B:SetText( "true,false,defult" )
textentry2B:SetDrawBackground(false)
textentrybg2B:SetPos( 0, 320 )
textentrybg2B:SetSize( 1254, 24 )
textentrybg2B:MoveToBack() 
textentrybg2B.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end

	local saveB = vgui.Create( "DButton", putintab2 )

saveB:SetTextColor( unclicked )	
saveB:SetText( "save and apply" )
saveB:SetSize( 1254, 24 )
saveB:SetPos( 0, 605 )
saveB.DoClick = function()
saveB:SetTextColor( clicked )
timer.Simple( revertclicktime, function() saveB:SetTextColor( unclicked ) end)

net.Start( "adi_send" )
net.WriteString( "save|"..textentry1B:GetValue().."|"..textentry2B:GetValue() ) 
net.SendToServer()

net.Start( "adi_send" )
net.WriteString( "execuate|*|"..textentry1B:GetValue().."|"..textentry2B:GetValue() ) 
net.SendToServer()

end
saveB.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

-- tab 3 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local text1C = vgui.Create( "DLabel", putintab3 )
	
text1C:SetPos( 0, 0 )
text1C:SetSize( 1254, 30 )
text1C:SetText( "More setting and technical infomation." )
text1C:SetFont( "DermaLarge" )
text1C:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text2C = vgui.Create( "DLabel", putintab3 )

text2C:SetPos( 0, 40 )
text2C:SetSize( 1254, 20 )
text2C:SetFont( "DermaMedium" )
text2C:SetText( "This page contains buttons and infomation that may come in very handy in the event you make a mistake or break something. You naughty person. The infomation may also provide you" )
text2C:SetTextColor( Color( 255, 255, 255, 255 ) )

	local text3C = vgui.Create( "DLabel", putintab3 )
	
text3C:SetPos( 0, 55 )
text3C:SetSize( 1254, 20 )
text3C:SetFont( "DermaMedium" )
text3C:SetText( "with usefull knowlage of how some of the things in admino work. The infomation:" )
text3C:SetTextColor( Color( 255, 255, 255, 255 ) )

for z = 1, table.maxn( technicalinfo ) do

	local listtextC = vgui.Create( "DLabel", putintab3 )
	
listtextC:SetPos( 30, 85 +( 15 *z ) )
listtextC:SetSize( 1254, 20 )
listtextC:SetFont( "DermaMedium" )
listtextC:SetText( "●  "..technicalinfo[z] )
listtextC:SetTextColor( Color( 255, 255, 255, 255 ) )

end 

	local uacmbaC = vgui.Create( "DButton", putintab3 )

uacmbaC:SetTextColor( unclicked )	
uacmbaC:SetText( "undo all changes made by admino" )
uacmbaC:SetSize( 1254, 24 )
uacmbaC:SetPos( 0, 437 )
uacmbaC.DoClick = function()
uacmbaC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( uacmbaC ) == true then uacmbaC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "uacmba" ) 
net.SendToServer()
end
uacmbaC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

	local ddciC = vgui.Create( "DButton", putintab3 )

ddciC:SetTextColor( unclicked )	
ddciC:SetText( "disable chat information" )
ddciC:SetSize( 1254, 24 )
ddciC:SetPos( 0, 465 )
ddciC.DoClick = function()
ddciC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( ddciC ) == true then ddciC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "dci" ) 
net.SendToServer()
end
ddciC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

	local dciC = vgui.Create( "DButton", putintab3 )

dciC:SetTextColor( unclicked )	
dciC:SetText( "enable chat information" )
dciC:SetSize( 1254, 24 )
dciC:SetPos( 0, 493 )
dciC.DoClick = function()
dciC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( dciC ) == true then dciC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "eci" ) 
net.SendToServer()
end
dciC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

	local delsaveC = vgui.Create( "DButton", putintab3 )

delsaveC:SetTextColor( unclicked )	
delsaveC:SetText( "delete save" )
delsaveC:SetSize( 1254, 24 )
delsaveC:SetPos( 0, 521 )
delsaveC.DoClick = function()
delsaveC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( delsave ) == true then delsaveC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "delsave" ) 
net.SendToServer()
end
delsaveC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

	local reloadsaveC = vgui.Create( "DButton", putintab3 )

reloadsaveC:SetTextColor( unclicked )	
reloadsaveC:SetText( "reload save" )
reloadsaveC:SetSize( 1254, 24 )
reloadsaveC:SetPos( 0, 549 )
reloadsaveC.DoClick = function()
reloadsaveC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( reloadsaveC ) == true then reloadsaveC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "reloadsave" ) 
net.SendToServer()
end
reloadsaveC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

	local delapcC = vgui.Create( "DButton", putintab3 )

delapcC:SetTextColor( unclicked )	
delapcC:SetText( "delete * changes" )
delapcC:SetSize( 1254, 24 )
delapcC:SetPos( 0, 577 )
delapcC.DoClick = function()
delapcC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( delapcC ) == true then delapcC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "delapc" ) 
net.SendToServer()
end
delapcC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

	local rapcC = vgui.Create( "DButton", putintab3 )

rapcC:SetTextColor( unclicked )	
rapcC:SetText( "reload * changes" )
rapcC:SetSize( 1254, 24 )
rapcC:SetPos( 0, 605 )
rapcC.DoClick = function()
rapcC:SetTextColor( clicked )
timer.Simple( revertclicktime, function() if IsValid( rapcC ) == true then rapcC:SetTextColor( unclicked ) end end)
net.Start( "adi_send" )
net.WriteString( "rapc" ) 
net.SendToServer()
end
rapcC.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 40, 0, 255 ) ) 
end

main.Paint = function( self, w, h )
draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 150, 255, 255 ) )
draw.RoundedBox( 0, 0, 0, w +2, 25, Color( 0, 100, 255, 255 ) )
      end	  
   end
end
