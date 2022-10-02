class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  # передаем локаль, которая юзается в данном запросе - та локаль, которая сейчас находится в треде,
  # будет добавлена в качестве используемой локали для следующего запроса.

  def default_url_options
    { locale: I18n.locale }
  end

  # Метод не принимает никаких аргументов, поскольку параметры запроса доступны в params.
  # В случае, если есть params[:locale] - записываем это в var locale. В противном случае
  # исп юзык по умолчанию.
  #
  # Для использования локали в контексте запроса, мы можем юзать метод I18n.with_locale(locale, &action)
  # или же просто I18n.locale(locale). Чем они отличаются?
  # Метод with_locale не имеет проблем с утечкой контекста: если вы указываете I18n.locale(locale) и у вас нет
  # процесса безопасности в приложении, то перевод может установиться и использоваться не только в контексте
  # того запроса, который вы обработали с нужным языком, но и примениться для какого-нибудь п-теля, который
  # этого совершенно не ожидает.
  def set_locale(&action)
    locale = params[:locale] || I18n.default_locale
    # первым аргументом передаем локаль, а вторым - блок, в котором название метода, с которым мы работаем.
    # I18n.with_locale(locale, &action)

    # В него задаете ту локаль, которую вы получилии.
    I18n.locale = locale.to_sym
  end

  # Установка локали через домен первого уровня уровня: .ru .en
  # parsed_locale - мы распарсили локаль, если она входит в число допустимых локалей для нашего
  # приложения, то мы её юзаем, если нет - записываем дефолтную локаль в нашу текущую I18n.locale
  def set_locale_second
    parsed_locale = request.host.split('.').last

    I18n.locale = if I18n.available_locales.include?(parsed_locale.to_sym)
                    parsed_locale
                  else
                    I18n.default_locale
                  end
  end

  # Если нужно поместить локаль в куку:
  # Мы забираем локаль или из params, или используем cookies[:locale], или юзаем I18n.default_locale
  # затем записываем значение(1 || 2 || 3) в локаль I18n.locale = locale.to_sym
  # после чего записываем значение в куку cookies[:locale] = I18n.locale. Теперь у пользователя будет лежать
  # в браузера та кука, с которой он последний раз работал
  def set_locale_cookies
    locale = params[:locale]      ||
             cookies[:locale]     ||
             current_user&.locale ||
             I18n.default_locale

    I18n.locale = locale.to_sym
    cookies[:locale] = I18n.locale

    current_user&.update(locale: I18n.locale)
  end

  def set_locale_from_header
    logger.debug(request.env['HTTP_ACCEPT_LANGUAGE'])
    # Мы будем получать язык с регионом, поэтому его нужно отсечь
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first

    logger.debug("LOCALE: #{locale}")

    I18n.locale = if I18n.available_locales.include?(locale.to_sym)
                    locale
                  else
                    I18n.default_locale
                  end
  end
end
