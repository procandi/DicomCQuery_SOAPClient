require 'rubygems'
require 'soap/rpc/driver'
require 'tk'
require 'scanf'


#connect to soap server and make soap event
@driver=SOAP::RPC::Driver.new('http://10.10.5.60:8888/', 'urn:SamewaySOAPServer')
@driver.add_method('movescu', 'patientid','accessionno')


#button event for btn_cquery2server, it will cquery server and response result.
def cquery2server(val1,val2)
  if val1.to_s()=="" || val2.to_s()==""
    @lbl_result.text="病歷號及單號不得為空."
  elsif val1.to_s().size()!=10
    @lbl_result.text="病歷號格式不正確."
  else
    begin
      @lbl_result.text=@driver.movescu(val1.to_s().scanf("%s")[0],val2.to_s().scanf("%s")[0])
    rescue
      @lbl_result.text="無法連線至WebService."
    end
  end
end


#make window root
@root=TkRoot.new{title "Sameway CQuery Tools"}

#make object
@lbl_result=TkLabel.new(@root){
  text "　　　　　　"
  font "arial 20 bold"
  foreground "red"
}

@lbl_patientid=TkLabel.new(@root){
  text "病歷號："
  font "arial 20 bold"
}
txt_val1=TkVariable.new
@txt_patientid=TkEntry.new(@root){
  text txt_val1
  font "arial 20 bold"
}

@lbl_accessionno=TkLabel.new(@root){
  text "　單號："
  font "arial 20 bold"
}
txt_val2=TkVariable.new
@txt_accessionno=TkEntry.new(@root){
  text txt_val2
  font "arial 20 bold"
}


@btn_cquery2server=TkButton.new(@root){
  text "確定"
  font "arial 20 bold"
}
@btn_cquery2server.command{cquery2server(txt_val1,txt_val2)}


#pack object 
#@lbl_result.pack
#@lbl_patientid.pack
#@txt_patientid.pack
#@lbl_accessionno.pack
#@txt_accessionno.pack
#@btn_cquery2server.pack
#@set object place
@lbl_result.place('x'=>20,'y'=>20,'width'=>350,'height'=>50)
@lbl_patientid.place('x'=>20,'y'=>90,'width'=>150,'height'=>50)
@txt_patientid.place('x'=>170,'y'=>90,'width'=>200,'height'=>50)
@lbl_accessionno.place('x'=>20,'y'=>160,'width'=>150,'height'=>50)
@txt_accessionno.place('x'=>170,'y'=>160,'width'=>200,'height'=>50)
@btn_cquery2server.place('x'=>220,'y'=>230,'width'=>150,'height'=>50)
#set window root place
@root.configure :width=>400,:height=>300
#loop window root
Tk.mainloop 
