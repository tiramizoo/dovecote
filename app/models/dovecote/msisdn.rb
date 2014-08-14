module Dovecote
  class Msisdn
      PhoneCodes = {
        "1" =>  [:ca, :pr, :us],
        "7" =>  [:kz, :ru],
        "20" => [:eg],
        "27" => [:za],
        "30" => [:gr],
        "31" => [:nl],
        "32" => [:be],
        "33" => [:fr],
        "34" => [:es],
        "36" => [:hu],
        "39" => [:it, :va],
        "40" => [:ro],
        "41" => [:ch],
        "43" => [:at],
        "44" => [:im, :gb],
        "45" => [:dk],
        "46" => [:se],
        "47" => [:no],
        "48" => [:pl],
        "49" => [:de],
        "51" => [:pe],
        "52" => [:mx],
        "53" => [:cu],
        "54" => [:ar],
        "55" => [:br],
        "56" => [:cl],
        "57" => [:co],
        "58" => [:ve],
        "60" => [:my],
        "61" => [:au, :cx, :cc],
        "62" => [:id],
        "63" => [:ph],
        "64" => [:nz],
        "65" => [:sg],
        "66" => [:th],
        "81" => [:jp],
        "82" => [:kr],
        "84" => [:vn],
        "86" => [:cn],
        "90" => [:tr],
        "91" => [:in],
        "92" => [:pk],
        "93" => [:af],
        "94" => [:lk],
        "95" => [:mm],
        "98" => [:ir],
        "212" => [:ma],
        "213" => [:dz],
        "216" => [:tn],
        "218" => [:ly],
        "220" => [:gm],
        "221" => [:sn],
        "222" => [:mr],
        "223" => [:ml],
        "224" => [:gn],
        "225" => [:ci],
        "226" => [:bf],
        "227" => [:ne],
        "228" => [:tg],
        "229" => [:bj],
        "230" => [:mu],
        "231" => [:lr],
        "232" => [:sl],
        "233" => [:gh],
        "234" => [:ng],
        "235" => [:td],
        "236" => [:cf],
        "237" => [:cm],
        "238" => [:cv],
        "239" => [:st],
        "240" => [:gq],
        "241" => [:ga],
        "242" => [:cg],
        "243" => [:cd],
        "244" => [:ao],
        "245" => [:gw],
        "248" => [:sc],
        "249" => [:sd],
        "250" => [:rw],
        "251" => [:et],
        "252" => [:so],
        "253" => [:dj],
        "254" => [:ke],
        "255" => [:tz],
        "256" => [:ug],
        "257" => [:bi],
        "258" => [:mz],
        "260" => [:zm],
        "261" => [:mg],
        "262" => [:yt],
        "263" => [:zw],
        "264" => [:na],
        "265" => [:mw],
        "266" => [:ls],
        "267" => [:bw],
        "268" => [:sz],
        "269" => [:km],
        "290" => [:sh],
        "291" => [:er],
        "297" => [:aw],
        "298" => [:fo],
        "299" => [:gl],
        "350" => [:gi],
        "351" => [:pt],
        "352" => [:lu],
        "353" => [:ie],
        "355" => [:al],
        "356" => [:mt],
        "357" => [:cy],
        "358" => [:fi],
        "359" => [:bg],
        "370" => [:lt],
        "371" => [:lv],
        "372" => [:ee],
        "373" => [:md],
        "374" => [:am],
        "375" => [:by],
        "376" => [:ad],
        "377" => [:mc],
        "378" => [:sm],
        "380" => [:ua],
        "381" => [:rs],
        "382" => [:me],
        "385" => [:hr],
        "386" => [:si],
        "387" => [:ba],
        "389" => [:mk],
        "420" => [:cz],
        "421" => [:sk],
        "423" => [:li],
        "500" => [:fk],
        "501" => [:bz],
        "502" => [:gt],
        "503" => [:sv],
        "504" => [:hn],
        "505" => [:ni],
        "506" => [:cr],
        "507" => [:pa],
        "508" => [:pm],
        "509" => [:ht],
        "590" => [:bl],
        "591" => [:bo],
        "592" => [:gy],
        "593" => [:ec],
        "595" => [:py],
        "597" => [:sr],
        "598" => [:uy],
        "670" => [:tl],
        "672" => [:aq],
        "673" => [:bn],
        "674" => [:nr],
        "675" => [:pg],
        "676" => [:to],
        "677" => [:sb],
        "678" => [:vu],
        "679" => [:fj],
        "680" => [:pw],
        "681" => [:wf],
        "682" => [:ck],
        "683" => [:nu],
        "685" => [:ws],
        "686" => [:ki],
        "687" => [:nc],
        "688" => [:tv],
        "689" => [:pf],
        "690" => [:tk],
        "691" => [:fm],
        "692" => [:mh],
        "850" => [:kp],
        "852" => [:hk],
        "853" => [:mo],
        "855" => [:kh],
        "856" => [:la],
        "870" => [:pn],
        "880" => [:bd],
        "886" => [:tw],
        "960" => [:mv],
        "961" => [:lb],
        "962" => [:jo],
        "963" => [:sy],
        "964" => [:iq],
        "965" => [:kw],
        "966" => [:sa],
        "967" => [:ye],
        "968" => [:om],
        "971" => [:ae],
        "972" => [:il],
        "973" => [:bh],
        "974" => [:qa],
        "975" => [:bt],
        "976" => [:mn],
        "977" => [:np],
        "992" => [:tj],
        "993" => [:tm],
        "994" => [:az],
        "995" => [:ge],
        "996" => [:kg],
        "998" => [:uz]
      }

    attr_reader :phone_code, :subscriber_number

    def initialize(phone_number, country_code = nil)
      # strip out spaces, dashes, backslashes
      phone_number = phone_number
        .sub(/(^00)/, "+")                       # 0049 -> +49
        .gsub(/\(0\d*\)/) { |s| s.sub("0", "") } # (0351) -> (351), (0) -> ()
        .gsub(/[^\d+]/, "") # strip everything but the digits and + (plus) sign
        .sub(/^0/, "")

      if msisdn = normalize_phone_number(phone_number, country_code)
        @phone_code        = msisdn[:phone_code]
        @subscriber_number = msisdn[:subscriber_number]
      end
    end

    def valid?
      phone_code && subscriber_number && subscriber_number.length.in?(7..14) && ((phone_code.length + subscriber_number.length) <= 15)
    end

    def to_s
      return "" unless valid?
      "+#{phone_code}.#{subscriber_number}"
    end

    private

    def normalize_phone_number(phone_number, country_code)
      if phone_number.starts_with?("+")
        if phone_code = phone_number_to_phone_code(phone_number)
          {phone_code: phone_code, subscriber_number: phone_number.sub("+#{phone_code}", "")}
        end
      elsif country_code && phone_code = country_code_to_phone_code(country_code)
        {phone_code: phone_code, subscriber_number: phone_number}
      end
    end

    def country_code_to_phone_code(country_code)
      return unless country_code
      PhoneCodes.detect { |phone_code, country_codes| country_codes.include?(country_code) }.try(:first)
    end

    def phone_number_to_phone_code(phone_number)
      return unless phone_number
      PhoneCodes.detect { |phone_code, country_codes| phone_number.starts_with?("+#{phone_code}") }.try(:first)
    end
  end
end
