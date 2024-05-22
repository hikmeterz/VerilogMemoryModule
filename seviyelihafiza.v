`timescale 1ns / 1ps

module seviyelihafiza(
    input clk,
    input[5:0] adres,
    input yazoku,
    input[7:0] deger,
    output[7:0] sonuc,
    output[1:0] hata_sayisi
 );
 
    reg [1:0] seviye1_hafiza [1:0];
    reg [2:0] seviye2_hafiza1 [3:0];
    reg [2:0] seviye2_hafiza2 [3:0];
    reg [7:0] hafiza [63:0];
    
    reg hata_sayisi_next=2'b00;
    reg hata_sayisi_r=2'b00;
    reg hangi_seviyedeyim=2'b01;
    reg hangi_seviyedeyim_next=2'b01;
    
    
    reg sonuc_r=7'b0000000;
    integer i;
    
    reg kontrol_seviye2=3'b000;
    reg kontrol_seviye1=2'b00;
    
    initial begin
    
        for(i=0;i<2;i=i+1)begin
            seviye1_hafiza[i]=2'd0;
        end
        
        for(i=0;i<4;i=i+1)begin
            seviye2_hafiza1[i]=3'd0;
        end
        
        for(i=0;i<4;i=i+1)begin
            seviye2_hafiza2[i]=3'd0;
        end
        
        for(i=0;i<64;i=i+1)begin
            hafiza[i]=8'd0;
        end
        
    end
    
    
    always@* begin
        hata_sayisi_next=hata_sayisi_r;
        hangi_seviyedeyim_next=hangi_seviyedeyim;
        if(yazoku==1'b1)begin//yazoku1 ise yazma islemi
             hafiza[adres]=deger;
        end
        else if(yazoku==1'b0) begin
            if(adres>=32&&hangi_seviyedeyim_next==2'b01)begin//seviye1_
               if(adres>=32 && adres<40)begin
                    if(seviye1_hafiza[1]!=2'b00)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b00;
                    end
               end
               else if(adres>=40 && adres<48)begin
                    if(seviye1_hafiza[1]!=2'b01)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b01;
                    end
               end
               else if(adres>=48 && adres<56)begin
                    if(seviye1_hafiza[1]!=2'b10)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b10;
                    end
               end
               else if(adres>=56 && adres<64)begin
                    if(seviye1_hafiza[1]!=2'b11)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b11;
                    end
               end
               
                hangi_seviyedeyim_next=hangi_seviyedeyim +2'b01; 
            end
            else if(adres<32&&hangi_seviyedeyim_next==2'b01)begin//seviye1_
               if(adres>=0 && adres<8)begin
                    if(seviye1_hafiza[0]!=2'b00)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b00;
                    end
               end
               else if(adres>=8 && adres<16)begin
                    if(seviye1_hafiza[0]!=2'b01)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b01;
                    end
               end
               else if(adres>=16 && adres<24)begin
                    if(seviye1_hafiza[0]!=2'b10)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b10;
                    end
               end
               else if(adres>=24 && adres<32)begin
                    if(seviye1_hafiza[0]!=2'b11)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye1_hafiza[1]=2'b11;
                    end
               end
                 hangi_seviyedeyim_next=hangi_seviyedeyim +2'b01; 
            end
            
            else if(adres>=32&&hangi_seviyedeyim_next==2'b10)begin//seviye2_
               if(adres>=32 && adres<40)begin
                    if(seviye2_hafiza2[0]!=adres-32)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza2[0]=adres-32;
                    end
               end
               else if(adres>=40 && adres<48)begin
                    if(seviye2_hafiza2[1]!=adres-40)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza2[1]=adres-40;
                    end
               end
               else if(adres>=48 && adres<56)begin
                    if(seviye2_hafiza2[2]!=adres-48)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza2[2]=adres-48;
                    end
               end
               else if(adres>=56 && adres<64)begin
                    if(seviye2_hafiza2[3]!=adres-56)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza2[3]=adres-56;
                    end
               end
               
                hangi_seviyedeyim_next=hangi_seviyedeyim +2'b01; 
            end
            
            
            else if(adres<32&&hangi_seviyedeyim_next==2'b10)begin//seviye2
               if(adres>=0 && adres<8)begin
                    if(seviye2_hafiza1[0]!=adres)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza1[0]=adres; 
                    end
               end
               else if(adres>=8 && adres<16)begin
                    if(seviye2_hafiza1[1]!=adres-8)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza1[1]=adres-8;
                    end
               end
               else if(adres>=16 && adres<24)begin
                    if(seviye2_hafiza1[2]!=adres-16)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza1[2]=adres-16;
                    end
               end
               else if(adres>=24 && adres<32)begin
                    if(seviye2_hafiza1[3]!=adres-24)begin
                        hata_sayisi_next=hata_sayisi_next+2'b01;
                        seviye2_hafiza1[3]=adres-24;
                    end
               end
                 hangi_seviyedeyim_next=hangi_seviyedeyim +2'b01; 
            end
            else if(hangi_seviyedeyim==2'b11)begin
                sonuc_r=hafiza[adres];//tum seviyeler bitti..
                hangi_seviyedeyim_next=2'b01;
                
            end
        end    
     
    end
   always@(posedge clk) begin
        hata_sayisi_r <= hata_sayisi_next;
        hangi_seviyedeyim <=hangi_seviyedeyim_next;
    end
    assign hata_sayisi=hata_sayisi_r;//bu duruma bak.....!!!!
    assign sonuc=sonuc_r;
endmodule
