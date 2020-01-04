from datetime import datetime


class Log:
    '''
    General class for assuring consistent logging throughout the crawler
    '''

    def __init__(self, context, verbose=True):
        # Context - name of currently running part of the program

        self.context = str(context)
        self.time_start = None
        self.running = False
        self.successful = None
        self.additional_info = []
        self.verbose = verbose

    def start(self):
        self.running = True
        self.time_start = datetime.now()

        if self.verbose:
            print(f"Running part '{self.context}...'")

    def add_info(self, info):
        self.additional_info.append(info)

        if self.verbose:
            print(f"Info: {info}")

    def end_successfully(self, info=None):
        self.running = False
        self.successful = True

        if info is not None:
            self.additional_info.append(info)

        if self.verbose:
            print(f'Part: "{self.context}" ended succesfully. Info: {info}')

    def end_with_error(self, info):
        self.running = False
        self.successful = False

        if info is not None:
            self.additional_info.append(info)

        if self.verbose:
            print(f'Part: "{self.context}" ended with error. Info: {info}')

    def _write_externally(self):
        # Here insert logic about writing to database, txt etc
        pass

    def __repr__(self):
        return str(f'context: "{self.context}", {self.additional_info}')
